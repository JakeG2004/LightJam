#!/bin/sh
printf '\033c\033]0;%s\a' LightJam
base_path="$(dirname "$(realpath "$0")")"
"$base_path/photofrenzy.x86_64" "$@"
