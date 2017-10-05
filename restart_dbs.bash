#!/usr/bin/env bash

pushd /Library/PostgreSQL/9.6
sudo -u postgres pg_ctl -D /Library/PostgreSQL/9.6/data stop
sudo -u postgres pg_ctl -D /Library/PostgreSQL/9.6/data start
popd

brew services restart redis

cp "$HOME/repos/stereostream/stereostream-scripts/nginx.full.conf" /usr/local/etc/nginx/nginx.conf
chown $USER:admin /usr/local/etc/nginx/nginx.conf
chmod 644 /usr/local/etc/nginx/nginx.conf
sudo brew services restart nginx
# Technically not a DB^!
