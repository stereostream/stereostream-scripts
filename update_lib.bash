#!/usr/bin/env bash

function ensure_env() {
    STEREOSTREAM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    export STEREOSTREAM_DIR="${STEREOSTREAM_DIR%/*}"
    export STEREOSTREAM_WEB_DIR="$STEREOSTREAM_DIR/stereostream-angular"
    export STEREOSTREAM_API_DIR="$STEREOSTREAM_DIR/stereostream-rest-api"
}

function update_deps() {
    pushd "$1"

    if [ -f typings.json ]; then
        rm -r node_modules typings package-lock.json
        typings i
    else
        rm -r node_modules package-lock.json
    fi

    npm i

    popd
}

function need_git_update() {
    pushd "$1"
    
    git remote update
    if [ $(git rev-parse HEAD) = $(git ls-remote $(git rev-parse --abbrev-ref @{u} | \
    sed 's/\// /g') | cut -f1) ]; then
        res=1;
    else 
        res=0;
    fi
    
    popd

    return "$res"
}
