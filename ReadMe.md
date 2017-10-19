

*Windows*にCentos7にApache,MariaDb,PHP環境を構築します。

## 前準備

* Vagrant インストール
* (virtualBox インストール)

## 仮想環境の構築

インストール
```
git clone https://github.com/yusaru/provision.git
```

### 仮想環境構築

Vagrantfileがあるパスで以下コマンドを実行

```
vagrant up
```

### Apache, MariaDb, PHPをインストールします

以下コマンドを実行

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
