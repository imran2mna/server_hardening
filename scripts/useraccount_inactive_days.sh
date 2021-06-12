#!/bin/env bash

if [ $# -lt 1 ]; then
	echo "Usage : $0 inactive_days" && exit 1
fi


for i in $(grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1)
do
	if [ ! $i == "root" ]; then
		chage --inactive $1 $i
	fi
done

for i in $(grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f7)
do
	if [ ! "$i" -eq $1 ]; then
		echo "validation failed." # && exit 1
	fi
done
