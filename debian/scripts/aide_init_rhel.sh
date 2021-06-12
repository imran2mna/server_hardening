#!/bin/env bash

aide -version || exit 2

if [ -f /var/lib/aide/aide.db.gz ]; then
	echo "Aide already initialized." && exit 0
fi

aide --init && mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz && exit 0 
