
# Ajenti インストール
# http://ajenti.org/
# クライアントブラウザからサーバ設定が出来るようになります。
# ブラウザからは"https://<address>:8000"でアクセス
# デフォルトID/Passは[root/admin]
# 設定から日本語を選べる。

execute "Install Ajenti" do
    not_if "rpm -q ajenti"
    user "root"
    command "curl https://raw.githubusercontent.com/ajenti/ajenti/1.x/scripts/install-rhel.sh | sh"
end
