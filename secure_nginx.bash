#!/usr/bin/env bash

echo "Securing nginx";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env;

ssl_dir='/usr/local/etc/nginx/ssl'
if [ -d "$ssl_dir" ]; then
	echo "Already generated. Exiting."
	exit
fi

keyfile="$ssl_dir/private/nginx-selfsigned.key"
crtfile="$ssl_dir/certs/nginx-selfsigned.crt"
pemcrtfile="$ssl_dir/certs/nginx-selfsigned.crt.pem"
csrfile="$ssl_dir/certs/nginx-selfsigned.csr"
pemfile="$ssl_dir/certs/dhparam.pem"
subj='/C=AU/ST=NSW/L=Sydney/O=Samuel Marks/OU=Sydney Scientific Pty Ltd/CN=offscale.io'
sudo mkdir -p "$ssl_dir/certs"
sudo mkdir -p "$ssl_dir/private"
sudo chmod -R 700 "$ssl_dir"
sudo chmod -R 400 "$ssl_dir/private"
sudo openssl req -x509 -nodes -days 730 -newkey rsa:4096 -keyout "$keyfile" -out "$crtfile" -subj "$subj"
sudo openssl req -new -key "$keyfile" -out "$csrfile" -subj "$subj"
sudo openssl dhparam -out "$pemfile" 1024
# It's a closed network; so this num ^ should be fine
sudo openssl x509 -inform PEM -outform PEM -in "$crtfile" -out "$pemcrtfile"
sudo security add-trusted-cert -d -r trustRoot -p ssl -k /Library/Keychains/System.keychain "$crtfile"
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$crtfile"
defaults write com.google.Chrome EnableCommonNameFallbackForLocalAnchors -bool true
LINE='export HOMEBREW_NO_AUTO_UPDATE=1'
FILE="$HOME/.bash_profile"
grep -qF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
[ ! -f /usr/local/opt/nss/bin/certutil ] && brew install nss
for profile in "$HOME"/Library/Application\ Support/Firefox/Profiles/*; do
	sudo /usr/local/opt/nss/bin/certutil -d "$profile" -D -n 'Samuel Marks' 2>/dev/null
	sudo /usr/local/opt/nss/bin/certutil -d "$profile" -D -n 'Samuel I. Marks' 2>/dev/null
	sudo /usr/local/opt/nss/bin/certutil -A -d "$profile" -i "$crtfile" -n 'Samuel Marks' -t 'C,,' 2>/dev/null
	sudo /usr/local/opt/nss/bin/certutil -A -d "$profile" -i "$pemcrtfile" -n 'Samuel I. Marks' -t 'C,,' 2>/dev/null
done
