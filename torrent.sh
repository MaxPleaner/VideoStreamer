#/usr/bin/env bash
#dir=/media/max/media/Movies/ALL/$1

echo "enter folder and name of folder e.g. Movies/cool_film"
read name

dir=/mnt/share/$name
mkdir -p "$dir"

echo "enter magnet url"
read url

transmission-cli -w "$dir" "$url"
