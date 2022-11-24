#!/bin/bash

function subfolders {
	size=${3::-2}"MB"
	addName=${1:0:1}
	folderName=$addName$addName$addName$1
	myDate=$(date +"%d%m%y")
	myAltVerb=${2%.*}
	altVerb=${myAltVerb:${myAltVerb}-1}
	myFile=${2%.*}$altVerb$altVerb$altVerb
	addWord=${myFile:${myFile}-1}
	addExten=\.${2#*.}

# Range all paths file system
	myRANGE=$(sudo du --max-depth=1 -h / 2>/dev/null | awk '{print $2}' | wc -l)
	root_number=$RANDOM
	let "root_number %=myRANGE"
	randomPath=$(sudo du --max-depth=1 -h / 2>/dev/null | awk '{print $2}' | tail -$root_number | head -1)
	exclude1="/proc"
	exclude2="/sys"
	if [[ $randomPath == $exclude1 ]] || [[ $randomPath == $exclude2 ]]; then
		randomPath=/home
		echo "$randomPath"
	fi

# Range for directories
	RANGE=100
	number=$RANDOM
	let "number %=RANGE"

	for ((i = 0; $number > i; i++)); do
		newDir=$randomPath/$folderName\_$myDate
		if ! [[ -d $newDir ]]
		then
			dirNames $newDir
			myFile=${2%.*}$altVerb$altVerb$altVerb
			file_name=$myFile\_$myDate$addExten
			RANGE_F=225
			file_number=$RANDOM
			let "file_number %=RANGE_F"

			for (( j=0; $file_number>j; j++ )); do
				sizeLimit
				fileNames $newDir $file_name $size
				myFile=$myFile$addWord
				file_name=$myFile\_$myDate$addExten
			done
			folderName=$addName$folderName
		else
			echo "Can't create directory, because $newDir already exist!"
			exec_time
			exit 1
		fi
	done
	exec_time
}

function dirNames {
	currentDate=$(date +"%d %B %Y")
	sudo mkdir $1
	echo "$1 $currentDate" >> history.log
}

function fileNames {
	b=${3::-2}
	a=$(($b * 1048576))
	sudo fallocate -l $a $1/$2 2>/dev/null
	echo "$1/$2 $currentDate $size" >> history.log
}

function logName {
	if ! [[ -f history.log ]]; then
		touch history.log
	fi
}
function sizeLimit {
	if [[ $(df / | awk '{print $4}' | tail -1) -le 1048576 ]]; then
		echo "The script is stopped because there is less than 1GB of free space left in the system"
		exec_time
		exit 1
	fi
}

function exec_time {
	DIFF=$(echo "$(date +%s.%N) - $START" | bc)
	echo "Script start time = $START_TIME" >> history.log
	echo "Script start time = $START_TIME"
	echo "Script end time = $(date +"%H:%M:%S")" >> history.log
	echo "Script end time = $(date +"%H:%M:%S")"
	printf "Script execution time (in seconds) = %.1f\n" $DIFF >> history.log
	printf "Script execution time (in seconds) = %.1f\n" $DIFF
}
