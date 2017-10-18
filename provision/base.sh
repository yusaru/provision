#!/bin/sh

echo '#### base.sh'

#### mirror
echo "prefer=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf

#### update
sudo yum update -y

# #### enviroment
# sudo yum install -y openssl-devel readline-devel zlib-devel

#### git
sudo yum -y install git

#### rbenv
# if [ ! -e '/home/vagrant/.rbenv' ]; then
#     git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
#     git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
#     echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
#     echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
#     source ~/.bash_profile
# fi

#### ruby
# rbenv install 2.4.2
# rbenv rehash
# rbenv global 2.4.2

# 高速!
sudo yum -y install https://github.com/feedforce/ruby-rpm/releases/download/2.4.2/ruby-2.4.2-1.el7.centos.x86_64.rpm
                   #https://github.com/feedforce/ruby-rpm/releases/download/2.2.4/ruby-2.2.4-1.el7.centos.x86_64.rpm
#### itamae
gem i itamae
