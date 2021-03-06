#!/usr/bin/env bash

echo "Updating web-frontend [dist]";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env

if [ ! -d "$STEREOSTREAM_WEB_DIST_DIR" ]; then
    mkdir -p "$STEREOSTREAM_WEB_DIST_DIR";
    git clone https://github.com/stereostream/stereostream-angular-dist "$STEREOSTREAM_WEB_DIST_DIR";
    # update_deps "$STEREOSTREAM_WEB_DIR";
else
    if need_git_update "$STEREOSTREAM_WEB_DIST_DIR"; then
        git reset --hard HEAD
        git pull
        # update_deps "$STEREOSTREAM_WEB_DIR"
    fi
fi

echo "Press ENTER to close (finished updating web frontend)";
