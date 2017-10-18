# Apache をインストールする手順

## Apache httpd をインストール  
package "httpd" do
  user "root"
end

## mod_sslパッケージをインストール
package "mod_ssl" do
  user "root"
end

# httpd.confのバックアップ
execute 'httpd.conf backup' do
  ## httpd.conf.orgがなければ
  not_if "test -e /etc/httpd/conf/httpd.conf.org"
  command 'cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org'
  user "root"
end

## Apache httpd 自動起動の設定をする
## Apache httpd の起動
service 'httpd' do
  user "root"
  action [:enable, :start]
end