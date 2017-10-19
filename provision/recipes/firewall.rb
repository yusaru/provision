# 開発環境なのでFireWallはバッサリカット
# firewalld

# # firewalld 起動と永続化
# service 'firewalld' do
#   action [:enable, :start]
# end

# ## パケットフィルタリングの設定
# ### httpd
# execute 'open http port' do
#   user "root"
#   command <<-EOL
# firewall-cmd --permanent --add-service=http
# firewall-cmd --reload
# EOL

# execute 'open https port' do
#   user "root"
#   command <<-EOL
# firewall-cmd --permanent --add-service=https
# firewall-cmd --reload
# EOL

### MariaDb
## 外部から接続しない限りいらない
# execute 'open db' do
#   user "root"
#   command <<-EOL
# firewall-cmd --permanent --add-service=mysql
# firewall-cmd --reload
# EOL
# end


### firewalldのリストは以下で確認
#firewall-cmd --list-services --zone=public  --permanent
#firewall-cmd --list-all

## firewalld に設定できるサービスのリスト
#/usr/lib/firewalld/services

## firewalld 適応
# firewall-cmd --reload