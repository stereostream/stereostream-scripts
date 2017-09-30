#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env

rm -rf "$STEREOSTREAM_API_DIR"
rm -rf "$STEREOSTREAM_WEB_DIR"

echo "Cleaned"

exit 0
