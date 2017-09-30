#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

pushd "$DIR/assets"

function install_dmg() {
    open -a "DiskImageMounter $1"
}

if [ -z "$NO_MOUNTY" ]; then
    install_dmg 'Mounty.dmg'
fi

if [ -z "$NO_REDIS" ]; then
    tar xf redis-4.0.2.tar.gz
    pushd redis-4.0.2
    make
    make install
    popd
fi

if [ -z "$NO_XCODE" ]; then
    open -a "'Archive Utility' 'Xcode8.3.3.xip'"
fi

if [ -z "$NO_DEVCLI" ]; then
    install_dmg 'Command_Line_Tools_macOS_10.12_for_Xcode_9.dmg'
fi

if [ -z "$NO_POSTGRES" ]; then
    install_dmg 'postgresql-9.6.5-1-osx.dmg'
fi

if [ -z "$NO_GIT" ]; then
    install_dmg 'git-2.14.1-intel-universal-mavericks.dmg'
fi

if [ -z "$NO_NODE" ]; then
    open -a "Installer 'node-v8.6.0.pkg'"
fi

popd
