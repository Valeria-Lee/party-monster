#!/bin/sh
printf '\033c\033]0;%s\a' party monster
base_path="$(dirname "$(realpath "$0")")"
"$base_path/party_monster.x86_64" "$@"
