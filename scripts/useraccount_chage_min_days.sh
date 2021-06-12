#!/bin/env bash

if [ $# -lt 1 ]; then
	echo "Usage : $0 min_days" && exit 1
fi


for i in $(grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1)
do
#if [ ! $i == "root" ]; then
	chage --mindays $1 $i
#fi
done

for i in $(grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f4)
do
	if [ ! "$i" -eq $1 ]; then
		echo "validation failed."  && exit 1
	fi
done
