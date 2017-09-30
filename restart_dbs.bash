#!/usr/bin/env bash

pushd /Library/PostgreSQL/9.6
sudo -u postgres pg_ctl -D /Library/PostgreSQL/9.6/data stop
sudo -u postgres pg_ctl -D /Library/PostgreSQL/9.6/data start
popd

brew services restart redis
