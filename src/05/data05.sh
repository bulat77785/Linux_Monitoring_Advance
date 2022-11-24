#!/bin/bash

function createLog {
	for i in {1..5}; do
		cat ../04/nginx0$i.log >> nginxBy.log
	done
}

function byAnswer {
	createLog
	cat nginxBy.log | awk '{print $0}' | sort -n -t ' ' -k 8,8
	cat nginxBy.log | awk '{print $0}' | sort -n -t ' ' -k 8,8 > 1nginx.log
#	rm nginxBy.log
}

function uniqIP {
	createLog
	cat nginxBy.log | awk '{print $1}' | sort -u
	cat nginxBy.log | awk '{print $1}' | sort -u > 2nginx.log
	rm nginxBy.log
}

function selectError {
	createLog
	cat nginxBy.log | awk '{if ($8 > 399) print $0}'
	cat nginxBy.log | awk '{if ($8 > 399) print $0}' > 3nginx.log
	rm nginxBy.log
}

function errorIP {
	createLog
	cat nginxBy.log | awk '{if ($8 > 399) print $1}' | sort -u
	cat nginxBy.log | awk '{if ($8 > 399) print $1}' | sort -u > 4nginx.log
	rm nginxBy.log
}
