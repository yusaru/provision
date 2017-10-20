# PHPのインストール

## リポジトリ追加
package "http://rpms.famillecollet.com/enterprise/remi-release-7.rpm" do
  not_if 'rpm -q remi-release'
  user "root"
end

## PHP7.1.10のインストール
%w(php php-cli php-common php-devel  php-gd php-mbstring php-mysqlnd php-pdo php-pear php-pecl-apcu php-soap php-xml php-xmlrpc)
.each do |pkg|
  package pkg do
    action :install
    options '-y --enablerepo=remi-php71'
    user "root"
  end
end

## php.iniのバックアップ
execute 'php.ini backup' do
  not_if "test -e /etc/php.ini.org"
  command 'cp /etc/php.ini /etc/php.ini.org'
  user "root"
end
