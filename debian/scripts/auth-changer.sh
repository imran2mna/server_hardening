#!/bin/bash

CP=$(authselect current | awk 'NR == 1 {print $3}' | grep custom/)

for FN in password-auth system-auth;
do
	[[ -n $CP ]] && PTF=/etc/authselect/$CP/$FN || PTF=/etc/authselect/$FN
	cp -f $PTF ${PTF}.orig	

	[[ -z $(grep -E '^\s*password\s+requisite\s+pam_pwquality.so\s+.*enforce-for-root\s*.*$' $PTF) ]] && sed -ri 's/^\s*(password\s+requisite\s+pam_pwquality.so\s+)(.*)$/\1\2 enforce-for-root/' $PTF 

	[[ -n $(grep -E '^\s*password\s+requisite\s+pam_pwquality.so\s+.*\s+retry=\S+\s*.*$' $PTF) ]] && sed -ri '/pwquality/s/retry=\S+/retry=3/' $PTF || sed -ri 's/^\s*(password\s+requisite\s+pam_pwquality.so\s+)(.*)$/\1\2 retry=3/' $PTF 
	
done

authselect apply-changes
if [ ! $? -eq 0 ]; then
	for FN in password-auth system-auth;
	do
		[[ -n $CP ]] && PTF=/etc/authselect/$CP/$FN || PTF=/etc/authselect/$FN
		mv ${PTF}.orig $PTF
	done
	
	authselect apply-changes
fi
