#!/bin/bash

function checkerByLog {
	cat history.log | while read y; do
		sudo rm -rf $y
	done
}

function checkerByDate {
	pamDS="^[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])$"
	pamS="^([0-1][0-9]|2[0-3])":"(0[0-9]|[1-5][0-9])$"

	read -p 'Please enter the start date in format: YYYY-MM-DD ' start_date
	if [[ $start_date =~ $pamDS ]]
	then
		read -p 'Please enter the start time up to the minute in format: hh:mm ' start_time
		if [[ $start_time =~ $pamS ]]
		then
			read -p 'Please enter the end date in format: YYYY-MM-DD ' end_date
			if [[ $end_date =~ $pamDS ]]
			then
				read -p 'Please enter the end time up to the minute in format: hh:mm ' end_time
				if [[ $end_time =~ $pamS ]]
				then
					cat history.log | while read y; do
						sudo find $y -type d -newerct "$start_date $start_time" ! -newerct "$end_date $end_time:59" -print -exec sudo rm -rf {} \; 2>/dev/null 1>/dev/null
					done
				else
					echo "End time entered incorrectly. Please start the script again"
					exit 1
				fi
			else
				echo "End date entered incorrectly. Please start the script again"
				exit 1
			fi
		else
			echo "Start time entered incorrectly. Please start the script again"
			exit 1
		fi
	else
		echo "Start date entered incorrectly. Please start the script again"
		exit 1
	fi
}

function checkerByMask {
	pathM=$(cat history.log | head -1 | awk '{print $1}' | rev | cut -d "/" -f 2 | rev)
	myNum="^[0-9]{6}$"
	myVerb="^[a-zA-Z]{2,7}$"

	read -p 'Please enter the name mask in format: *_DDMMYY (* - a list of English alphabet. 2-7 characters.): ' mask
	mask1=${mask%_*}
	mask2=${mask#*_}
	if [[ $mask2 =~ $myNum ]]; then
		if [[ $mask1 =~ $myVerb ]]; then
			cat history.log | while read y; do
				sudo rm -rf /$pathM/*$mask 2>/dev/null
			done
		else
			echo "Incorrect symbols in a part for a list of English alphabet. 2-7 characters. Total number of characters must be in range 9-14."
			exit 1
		fi
	else
		echo "date is incorrect"
		exit 1
	fi
}
