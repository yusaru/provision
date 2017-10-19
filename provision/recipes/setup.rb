
# 実行コマンド
# vagrant ssh -c "itamae local /vagrant/provision/recipes/setup.rb"

### yum update をしないとfirewalldが反応しない
execute "update yum repo" do
  user "root"
  command "yum -y update"
end

# firewalld停止,無効化
service 'firewalld' do
  action [:disable, :stop]
end


include_recipe "./Apache/apache.rb"
include_recipe "./MariaDb/mariaDb.rb"
include_recipe "./PHP/php.rb"

###
## サーバ管理ツール https://<address>:8000
###
# include_recipe "./Ajenti/ajenti.rb"

###
## サーバ監視ツール http://<address>/munin
###
## include_recipe "./Munin/munin.rb"


include_recipe "./firewall.rb"