#!/usr/bin/env bash

pkill node
lsof -t -i tcp:4200 | xargs kill -9
pkill redis-server
