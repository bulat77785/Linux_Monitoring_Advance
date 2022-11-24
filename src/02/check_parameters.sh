#!/bin/bash

. ./data02.sh

if [[ $1 ]]
then
	if [[ -n $2 ]] && [[ -n $3 ]]
	then
		if [[ $4 ]]
		then
			echo "More than three parameters have been entered"
			exit 1
		else
			pam1="^[a-zA-Z]{2,7}$"
			if [[ $1 =~ $pam1 ]]
			then
				pam2="^[a-zA-Z]{2,7}"."[a-z]{1,3}$"
				if [[ $2 =~ $pam2 ]]
				then
					pam3="^(100|[1-9][0-9]?)[M][bB]$"
					if [[ $3 =~ $pam3 ]]
					then
						logName
					else
						echo "Incorrect parameter 3. Please enter file size in megabytes (MB, Mb), but not more than 100."
						exit 1
						fi
				else
					echo "Incorrect parameter 2. Please enter a list of English alphabet letters used in the filenave and extension. 2-7 characters for the name, no more than 3 characters for the extension)."
					exit 1
				fi
			else
				echo "Please enter a list of English alphabet. 2-7 characters."
				exit 1
			fi
		fi
	else
		echo "Not all parameters are specified"
		exit 1
	fi
else
	echo "No parameter has been entered"
	exit 1
fi
