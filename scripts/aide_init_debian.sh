#!/bin/env bash

aide -version || exit 2

if [ -f /var/lib/aide/aide.db ]; then
	echo "Aide already initialized." && exit 0
fi

/usr/sbin/aideinit && mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db && exit 0 
