#!/bin/env bash
for usr in $(cut -d: -f1 /etc/shadow)
do
	[[ $(chage --list $usr | grep '^Last password change' | cut -d: -f2) > $(date) ]] && echo "$usr:$(chage --list $usr | grep '^Last password change' | cut -d: -f2)" || [ 1 -eq 1 ]

done
