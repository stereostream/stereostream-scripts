#!/usr/bin/env bash

pkill node
lsof -t -i tcp:4200 | xargs kill -9 &> /dev/null
# pkill redis-server
