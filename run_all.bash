#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env

redis-server &

pushd "$STEREOSTREAM_API_DIR"
tsc
npm start &
popd

pushd "$STEREOSTREAM_WEB_DIR"
npm start &
open -a "Firefox http://localhost:4200"
popd
