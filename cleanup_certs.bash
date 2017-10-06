#!/usr/bin/env bash

for profile in "$HOME"/Library/Application\ Support/Firefox/Profiles/*; do
  	sudo /usr/local/opt/nss/bin/certutil -d "$PWD" -D -n 'Samuel Marks' 2>/dev/null
		sudo /usr/local/opt/nss/bin/certutil -d "$PWD" -D -n 'Samuel I. Marks' 2>/dev/null
done
