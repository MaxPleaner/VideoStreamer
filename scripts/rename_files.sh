cd /mnt/share/Movies && find . -depth -name '* *' -execdir bash -c 'for i; do mv "$i" "${i// /_}"; done' _ {} +
