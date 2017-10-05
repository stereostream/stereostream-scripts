#!/usr/bin/env bash

pkill node bunyan
lsof -t -i tcp:4200 | xargs kill -9 &> /dev/null
