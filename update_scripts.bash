#!/usr/bin/env bash

echo "Updating scripts";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env
STEREOSTREAM_SCRIPTS_DIR="$STEREOSTREAM_DIR/stereostream-scripts"
if [ ! -d "$STEREOSTREAM_SCRIPTS_DIR" ]; then
    mkdir -p "$STEREOSTREAM_SCRIPTS_DIR";
    git clone https://github.com/stereostream/stereostream-scripts "$STEREOSTREAM_SCRIPTS_DIR";
    # update_deps "$STEREOSTREAM_WEB_DIR";
else
    if need_git_update "$STEREOSTREAM_SCRIPTS_DIR"; then
        git reset --hard HEAD
        git pull
        # update_deps "$STEREOSTREAM_WEB_DIR"
    fi
fi

echo "Press ENTER to close (finished updating scripts)";
