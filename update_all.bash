#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Might as well...
bash "$DIR/kill_all.bash"

bash "$DIR/update_web_frontend.bash"
bash "$DIR/update_api.bash"
bash "$DIR/update_scripts.bash"
