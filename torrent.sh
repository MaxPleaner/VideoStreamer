#/bin/bash
#dir=/media/max/media/Movies/ALL/$1

echo "enter folder and name of folder e.g. Movies/cool_film"
read name

dir=/mnt/share/$name
mkdir -p "$dir"

echo "enter magnet url"
read url

# transmission-remote -n 'max:skam69' -a "$url" -w "$dir"

tmpfile=$(mktemp)
chmod a+x $tmpfile
echo "killall transmission-cli" > $tmpfile

safename=$(echo "$name" | sed 's/\//_/g')
# echo $safename

# screen -dmS $safename bash -c 'transmission-cli -f $tmpfile -w "$dir" "$url"; screen -X quit'
# screen -dmS $safename bash -c 'transmission-cli  -w "$dir" "$url"; screen -X quit'

transmission-cli -f $tmpfile -w "$dir" "$url"
