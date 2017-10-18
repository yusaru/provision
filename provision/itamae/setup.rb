
# 実行コマンド
# vagrant ssh -c "itamae local /vagrant/provision/itamae/setup.rb"

### yum update をしないとfirewalldが反応しない
execute "update yum repo" do
  user "root"
  command "yum -y update"
end

# 開発環境なのでFireWallはバッサリカット
# firewalld停止,無効化
service 'firewalld' do
  action [:disable, :stop]
end


# include_recipe "./recipes/apache.rb"
include_recipe "./recipes/mariaDb.rb"
# include_recipe "./recipes/php.rb"



# firewalld

## firewalld 起動と永続化
# service 'firewalld' do
#   action [:enable, :start]
# end

## パケットフィルタリングの設定
### httpd
# execute "firewall-cmd" do
#   user "root"
#   command "firewall-cmd --permanent --add-service=http;firewall-cmd --reload"
# end

### MariaDb
# execute 'open db' do
#   user "root"
#   command <<-EOL
# firewall-cmd --permanent --add-service=mysql
# firewall-cmd --reload
# EOL
# end


