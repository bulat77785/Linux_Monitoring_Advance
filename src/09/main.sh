#!/bin/bash

if [[ $# != 0 ]]; then
	echo "No parameter input is required"
	exit 1
else
	while true; do
		if [[ -f metrics.html ]]; then
			rm metrics.html
		fi
		CPU="$(cat /proc/loadavg | awk '{print $1}')"
		RAM="$(free | grep Mem | awk '{print $3}')"
		HD="$(df / | grep / | awk '{print $2}')"
		HD_Available="$(df / | grep / | awk '{print $4}')"

		echo -e "# HELP go_cpu Information about cpu" >> metrics.html
		echo -e "# TYPE go_cpu gauge" >> metrics.html		
		echo -e "go_cpu $CPU" >> metrics.html
		echo -e "# HELP go_capacity Information about hard disk capacity" >> metrics.html
		echo -e "# TYPE go_capacity gauge" >> metrics.html
		echo -e "go_capacity $HD" >> metrics.html
		echo -e "# HELP go_capacity_available Information about vailable hard disk capacity" >> metrics.html
		echo -e "# TYPE go_capacity_available gauge" >> metrics.html
		echo -e "go_capacity_available $HD_Available" >> metrics.html
		echo -e "# HELP go_ram Information about ram" >> metrics.html
		echo -e "# TYPE go_ram gauge" >> metrics.html
		echo -e "go_ram $RAM" >> metrics.html	
		sleep 3
	done
fi
