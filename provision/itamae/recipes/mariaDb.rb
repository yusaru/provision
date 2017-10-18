# MariaDBをインストールする手順

# MariaDB インストール
package 'mariadb-server' do
  user "root"
  action :install
end

# my.cnfのバックアップ
execute 'my.cnf backup' do
  not_if "test -e /etc/my.cnf.org"
  command 'cp /etc/my.cnf /etc/my.cnf.org'
  user "root"
end

# 起動・永続化
service 'mariadb' do
  action [:enable, :start]
end

execute "mysqladmin root password" do
  user "root"
  # パスワードが未設定なら
  only_if "mysql -u root -e 'show databases' | grep information_schema"
  command <<-EOL
mysqladmin -u root password 'Scheduler201709'
mysqladmin -p -u root -h localhost password 'Scheduler201709'
EOL
end
