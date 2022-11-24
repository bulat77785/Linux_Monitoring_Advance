#!/bin/bash

function subfolders {
	size=${6::-2}"K"
	addName=${3:0:1}
	folderName=$addName$addName$3
	myDate=$(date +"%d%m%y")
	myAltVerb=${5%.*}
	altVerb=${myAltVerb:${myAltVerb}-1}
	myFile=${5%.*}$altVerb$altVerb
	addWord=${myFile:${myFile}-1}
	addExten=\.${5#*.}
	for ((i = 0; $2 > i; i++)); do
		newDir=$1/$folderName\_$myDate
		if ! [[ -d $newDir ]]
		then
			dirNames $newDir
			myFile=${5%.*}$altVerb$altVerb
			file_name=$myFile\_$myDate$addExten
			for (( j=0; $4>j; j++ )); do
				sizeLimit
				fileNames $newDir $file_name $size
				myFile=$myFile$addWord
				file_name=$myFile\_$myDate$addExten
			done
			folderName=$addName$folderName
		else
			echo "Can't create directory, because $newDir already exist!"
			exit 1
		fi
	done
}

function dirNames {
	currentDate=$(date +"%d %B %Y")
	mkdir $1
	echo "$1 $currentDate" >> history.log
}

function fileNames {
	fallocate -l $3 $1/$2
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
		exit 1
	fi
}
