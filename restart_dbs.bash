#!/usr/bin/env bash

echo "Restarting DBs &etc.";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

pushd /Library/PostgreSQL/9.6
sudo -u postgres pg_ctl -D /Library/PostgreSQL/9.6/data stop
sudo -u postgres pg_ctl -D /Library/PostgreSQL/9.6/data start
popd

brew services restart redis
ensure_env
sed "s/\$USER/$USER/g" "$HOME/repos/stereostream/stereostream-scripts/nginx.full.conf" > /usr/local/etc/nginx/nginx.conf
chown $USER:admin /usr/local/etc/nginx/nginx.conf
chmod 644 /usr/local/etc/nginx/nginx.conf
sudo mkdir -p /var/www/static
sudo rm -f /var/www/static/stereostream-angular-dist
sudo chown -R $USER:wheel "$STEREOSTREAM_WEB_DIST_DIR"
sudo ln -s "$STEREOSTREAM_WEB_DIST_DIR" /var/www/static/stereostream-angular-dist
bash "$DIR/secure_nginx.bash"
sudo brew services restart nginx
# Technically not a DB^!
