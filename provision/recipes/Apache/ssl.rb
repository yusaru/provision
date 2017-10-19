### Let's Encrypt

package "openssl" do
  user "root"
end

package "certbot" do
    options "-y"
    user "root"
end

package "python-certbot-apache" do
    options "-y"
    user "root"
end