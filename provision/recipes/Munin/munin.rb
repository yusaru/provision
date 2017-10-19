# 監視ツールのインストール

# munin のデフォルト更新間隔は5分
# muninをインストールすると/etc/cron.d/muninが作成さル。
# 必要に応じて間隔を調整します。実行されるファイルは/usr/bin/munin-cron。

package "munin" do
    options "-y"
    user "root"
end

## htaccessによるBasic認証
execute "htpasswd -m /etc/munin/munin-htpasswd munin" do
    command "htpasswd -m /etc/munin/munin-htpasswd munin"
    user "root"
end

# 起動・永続化
service 'munin' do
    action [:enable, :start]
    user "root"
end

# http://xxx.xxx.xxx.xxx/munin
# ( xxx.xxx.xxx.xxxはあなたのVPSのIPアドレス)
# にアクセスし、
# ユーザー：munin
# パスワード： htpasswdコマンドであなたが決めたパスワード
  
# apache の監視
execute "command" do
    command <<-EOL
ln -s /usr/share/munin/plugins/apache_accesses /etc/munin/plugins/apache_accesses
ln -s /usr/share/munin/plugins/apache_processes /etc/munin/plugins/apache_processes
ln -s /usr/share/munin/plugins/apache_volume /etc/munin/plugins/apache_volume
EOL
end

# 再起動
%w(httpd munin-node).each do |srv|
    service srv do
        action [:restart]
        user "root"
    end
end

## 確認 数字が帰る
## munin-run apache_accesses
## munin-run apache_processes
## munin-run apache_volume

# mariaDb の監視
ln -s /usr/share/munin/plugins/mysql_bytes /etc/munin/plugins/
ln -s /usr/share/munin/plugins/mysql_queries /etc/munin/plugins/
ln -s /usr/share/munin/plugins/mysql_slowqueries /etc/munin/plugins/
ln -s /usr/share/munin/plugins/mysql_threads /etc/munin/plugins/

/etc/munin/plugin-conf.d/munin-node
[mysql*]
env.mysqlopts -u munin -ppassword -h 127.0.0.1 --port=3306

/etc/my.cnf
slow_query_log=1
slow_query_log_file=/var/log/mysql-slow.log
long_query_time=10

touch /var/log/mysql-slow.log
chown mysql:mysql /var/log/mysql-slow.log

# 再起動
%w(mysqld munin-node).each do |srv|
    service srv do
        action [:restart]
        user "root"
    end
end

### 確認 
#munin-run mysql_bytes
#munin-run mysql_queries
#munin-run mysql_slowqueries
#munin-run mysql_threads

### 参考 
# https://knowledge.sakura.ad.jp/3669/
# https://qiita.com/zaburo/items/e7b9475136e145f0f203