
# 使い方

Centos7にApache,MariaDb,PHP環境を構築します。

* Centos

## 前準備

* Vagrant インストール
* (virtualBox インストール)

## 仮想環境の構築

ローカル環境にCloneして以下を実行

### 仮想環境構築

Vagrantfileがあるパスで

```
vagrant up
```

### Apache, MariaDb, PHP インストール

```
vagrant ssh -c "itamae local /vagrant/provision/recipes/setup.rb"
```

サーバ監視(munin)、サーバ管理(ajenti)ツールをインストールする場合は、
`.\provision\recipes\setup.rb`の以下2つをコメントアウトしてください

* `include_recipe "./Ajenti/ajenti.rb"`
* `include_recipe "./Munin/munin.rb"`

> itamaeを使用して、個別にインストールも可能です。  
> `vagrant ssh -c "itamae local /vagrant/provision/recipes/Ajenti/ajenti.rb"`  
> `vagrant ssh -c "itamae local /vagrant/provision/recipes/Munin/munin.rb"`
