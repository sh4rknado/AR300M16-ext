#!/bin/bash
echo "[*] Restoring config defaults"
ls *.master | while read f; do
	name="$(echo $f|sed -e 's/\.master$//')"
	cmp $f $name > /dev/null || cp -v $f $name
done