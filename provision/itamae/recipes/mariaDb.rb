# MariaDBをインストールする手順

# MariaDB インストール
package 'mariadb-server' do
  user "root"
  action :install
end

# 起動・永続化
service 'mariadb' do
  action [:enable, :start]
  user "root"
end

# # my.cnfのバックアップ
execute 'my.cnf backup' do
  not_if "test -e /etc/my.cnf.org"
  command 'cp /etc/my.cnf /etc/my.cnf.org'
  user "root"
end

execute "mysqladmin root password DBのパスワードを入力してください。" do
  user "root"
  # パスワードが未設定なら
  only_if "mysql -u root -e 'show databases' | grep information_schema"
  command <<-EOL
mysqladmin -u root password 'password'
mysqladmin -p -u root -h localhost password 'password'
EOL
end
