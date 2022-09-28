#/usr/bin/env bash
dir=/media/max/media/Movies/ALL/$1

mkdir "$dir"
transmission-cli -w "$dir" "$2"
