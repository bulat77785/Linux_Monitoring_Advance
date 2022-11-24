#!/bin/bash

if [[ $# != 0 ]]; then
	echo "No parameter input is required"
	exit 1
else
	goaccess ../05/1nginx.log --log-format=COMBINED --invalid-requests=invalid.log -a -o 12index.html
	goaccess ../05/3nginx.log --log-format=COMBINED --invalid-requests=invalid.log -a -o 34index.html
fi
