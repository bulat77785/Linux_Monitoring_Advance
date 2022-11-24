#!/bin/bash

. ./check_parameters03.sh

if [[ $1 ]]
then
	if ! [[ $2 ]]
	then
		pam1="^[1-3]"
		if [[ $1 =~ $pam1 ]]
		then
			if [[ $1 -eq 1 ]]
			then
				checkerByLog $1
			fi
			
			if [[ $1 -eq 2 ]]
			then
				checkerByDate
			fi

			if [[ $1 -eq 3 ]]
			then
				checkerByMask
			fi
		else
			echo "Parameter must be in range from 1 to 3. Please try again."
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
