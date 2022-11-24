#!/bin/bash

. ./data05.sh

if [[ nginxBy.log ]]; then
	rm nginxBy.log 2>/dev/null
fi

if [[ $1 ]]; then
	if ! [[ $2 ]]; then
		pam1="^[1-4]"
		if [[ $1 =~ $pam1 ]]; then
			if [[ $1 -eq 1 ]]; then
				byAnswer $1
			fi
			
			if [[ $1 -eq 2 ]]; then
				uniqIP
			fi

			if [[ $1 -eq 3 ]]; then
				selectError
			fi

			if [[ $1 -eq 4 ]]; then
				errorIP
			fi
		else 
			echo "Parameter must be in range from 1 to 4"
			exit 1
		fi
	else
		echo "More than one parameter have been entered"
		exit 1
	fi
else
	echo "No parameter has been entered"
	exit 1
fi
