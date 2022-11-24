#!/bin/bash

. ./data01.sh

	if [[ $1 ]]
	then
		if [[ -n $2 ]] && [[ -n $3 ]] && [[ -n $4 ]] && [[ -n $5 ]] && [[ -n $6 ]]
		then
			if [[ ${1: -1} = "/" ]] || ! [[ -d $1 ]]
			then
				echo "Path do not exist. Remember, parameter should not end with \"/\""
				exit 1
			else
				if [[ $7 ]]
				then
					echo "More than six parameters have been entered"
					exit 1
				else
					pam2="^[1-9][0-9]+?$"
					if [[ $2 =~ $pam2 ]] && [[ $4 =~ $pam2 ]]
					then
						pam3="^[a-zA-Z]{2,7}$"
						if [[ $3 =~ $pam3 ]]
						then
							pam5="^[a-zA-Z]{2,7}"."[a-z]{1,3}$"
							if [[ $5 =~ $pam5 ]]
							then
								pam6="^(100|[1-9][0-9]?)[k][bB]$"
								if [[ $6 =~ $pam6 ]]
								then
									logName
								else
									echo "Incorrect parameter 6. Please enter file size in kilobytes (kb, kB), but not more than 100."
									exit 1
									fi
							else
								echo "Incorrect parameter 5. Please enter a list of English alphabet letters used in the filenave and extension. 2-7 characters for the name, no more than 3 characters for the extension)."
								exit 1
							fi
						else
							echo "Please enter a list of English alphabet. 2-7 characters."
							exit 1
						fi
					else
						echo "Incorrect parameter 2 or 4, or 2 and 4. Please enter a positive integer."
						exit 1
					fi
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
