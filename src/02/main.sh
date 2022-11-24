#!/bin/bash

. ./data02.sh
. ./check_parameters.sh

START=$(date +%s)
START_TIME=$(date +"%H:%M:%S")

subfolders $1 $2 $3
