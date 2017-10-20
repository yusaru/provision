# CentOS7 + Apache2.4 + MariaDb5.5 + PHP2.4 ローカル開発環境 on Windows

*Windows*にCentos,Apache,MariaDb,PHP環境を構築します。

構築後確認したバージョンは以下になります。

* CentOS Linux release 7.4.1708 (Core)
* Apache/2.4.6
* 5.5.56-MariaDB MariaDB Server
* PHP 7.1.10

## 確認環境

windows8.1 Pro

## 前準備

### **Git Bash**インストール

bash環境の用意、ssh接続が可能になるので便利です。

[https://git-for-windows.github.io/](https://git-for-windows.github.io/)

### **VirtualBox**インストール

CentosをVirtualBox上に構築します。

ダウンロード  
[https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

### **Vagrant**インストール

VirtualBoxの操作、Centosの設定、プロビジョニングなどに使用します。  

ダウンロード  
[https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

> Vagrantについての概要は以下を参考  
> [https://www.vagrantup.com/docs/](https://www.vagrantup.com/docs/)  
> [https://qiita.com/kidach1/items/e63c1607705178aa257c](https://qiita.com/kidach1/items/e63c1607705178aa257c)  

インストールが完了したら下記インストール確認を行い、**Vagrant Plugin**を導入します。  
コマンドを実行してください。

```
vagrant plugin install vagrant-vbguest
```

### インストール確認

以下のコマンドを実行します。
```
git --version
ssh -V
vagrant --version
```

結果  
```
git version 2.6.2.windows.1
OpenSSH_7.1p1, OpenSSL 1.0.2d 9 Jul 2015
Vagrant 2.0.0
```

## 仮想環境の構築

仮想マシンの構成ファイルを落とします。
任意の作業フォルダで行ってください。
例) ~/dev/

```
git clone https://github.com/yusaru/provision.git
```

フォルダ構成 

* Vagrantfile  
仮想マシンを構築する設定ファイルです。  
以下デフォルト値です。適宜設定を変更してください。  
    * マシン名:cos7
    * プライベートネットワーク:192.168.30.10
* provision/base.sh  
仮想マシン構築後の初期設定です。
    * **git**,**ruby**,**itamae**をインストールします。
    * itamaeはchef,ansibleのようなプロビジョニングツールです。  
簡単なのでこちらでプロビジョニングします。
    * git,rubyはitamaeをインストールするのに必要です。
* recipes  
itamaeの設定ファイルです。  
setup.rbをを実行してapache,php,mariadbを自動インストールします。
    * mariadbのルートパスは`password`です。  
変更する場合は`mariaDb.rb`の設定値を変更してください。
    * firewallはDisableです。必要に応じて立ち上げてください。


仮想マシンの起動
> Vagrantfileと同じディレクトリで行います。

```
vagrant up
```

初回はBoxファイルをダウンロード、インストールするため時間がかかります。  

起動が完了したらSSHでログインします。  
デフォルトのユーザ、パスワードはvagrant,vagrantになっています。

```
vagrant ssh
```
もしくは
```
ssh vagrant@192.168.30.10
```
`192.168.30.10`はVagrantfileで設定されたアドレスになります。

### Apache,MariaDb,PHPをインストールします

以下コマンドを実行するとApache,MariaDb,PHPを自動インストールと設定、起動と永続化を行います。

```
vagrant ssh -c "itamae local /vagrant/provision/recipes/setup.rb"
```

### 他ツール

サーバ監視(munin)、サーバ管理(ajenti)ツールをインストールする場合は、
`.\provision\recipes\setup.rb`の以下2つをコメントアウトしてください

* `include_recipe "./Ajenti/ajenti.rb"`
* `include_recipe "./Munin/munin.rb"`

