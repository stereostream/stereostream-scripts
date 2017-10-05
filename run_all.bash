#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env

# redis-server &

pushd "$STEREOSTREAM_API_DIR"
tsc
npm start &
popd

exec 6<>/dev/tcp/127.0.0.1/80 || no_nginx=1
exec 6>&- # close output connection
exec 6<&- # close input connection

no_nginx && sudo brew services start nginx

#pushd "$STEREOSTREAM_WEB_DIR"
#npm start &
private_ip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
gsleep 1m && open -a Firefox "http://$private_ip"
#popd
