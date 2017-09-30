#!/usr/bin/env bash

echo "Updating API";

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "$DIR/update_lib.bash";

ensure_env;

if [ ! -d "$STEREOSTREAM_API_DIR" ]; then
	mkdir -p "$STEREOSTREAM_API_DIR";
	git clone https://github.com/stockrankr/stockrankr-rest-api "$STEREOSTREAM_API_DIR";
	update_deps "$STEREOSTREAM_API_DIR";
else
	if need_git_update "$STEREOSTREAM_API_DIR"; then
		git reset --hard HEAD
		git pull
		update_deps "$STEREOSTREAM_API_DIR"
	fi
fi

echo "Press ENTER to close";
