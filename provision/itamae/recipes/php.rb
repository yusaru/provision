# PHP のインストール

execute "yum install remi-release-7.rpm" do
  user "root"
  command "yum install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm"
end

package 'php php-cli php-common php-devel php-fpm php-gd php-mbstring php-mysqlnd php-pdo php-pear php-pecl-apcu php-soap php-xml php-xmlrpc' do
  options '--enablerepo=remi-php71'
  user "root"
end

# php.iniのバックアップ
execute 'php.ini backup' do
  not_if "test -e /etc/php.ini.org"
  command 'cp /etc/php.ini /etc/php.ini.org'
end

# PHP Admin
package 'phpmyadmin' do
  options '--enablerepo=remi-php71'
  user "root"
end

# phpMyAdmin.confのバックアップ
execute 'phpMyAdmin.conf backup' do
  not_if "test -e /etc/httpd/conf.d/phpMyAdmin.conf.org"
  command 'cp /etc/httpd/conf.d/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf.org'
end
