#!/bin/bash

#Listing the variables

LOG_FILES[1]="heart_rate.log"
LOG_FILES[2]="temperature.log"
LOG_FILES[3]="water_usage.log"

# First creating the menu
echo "Select log to archive"
echo "1) Heart Rate "
echo "2) Temperature "
echo "3) Water Usage "
echo ""
read -p "Enter choice (1-3): " user_choice

arch_dir="archived_logs"

#Check if the archived_logs directory exists
if [[ ! -d "$arch_dir" ]]; then
	mkdir "$arch_dir"
fi

#Creating the the timestamp
timestamp=$(date "+%Y-%m-%d_%H:%M:%S")

#Case statements to user choice
case $user_choice in
	1)
		file_dir="heart_data_archive"

echo "Archiving heart rate log ..."

