#!/bin/bash

#Listing the variables, defining the log files

LOG_FILES[1]="heart_rate.log"
LOG_FILES[2]="temperature.log"
LOG_FILES[3]="water_usage.log"

# First creating the menu to display
echo "Select log to archive"
echo "1) Heart Rate "
echo "2) Temperature "
echo "3) Water Usage "
echo ""
read -p "Enter choice (1-3): " user_choice

arch_dir="archived_logs"

#Creating the the timestamp
timestamp=$(date "+%Y-%m-%d_%H:%M:%S")

#Check if the archived_logs directory exists
if [[ ! -d "$arch_dir" ]]; then
        mkdir "$arch_dir"
fi


case $user_choice in
    1)
        file_dir="heart_data_archive"
        echo "Archiving heart rate log ..."
        log_file="${LOG_FILES[1]}"
        active_log_path="hospital_data/active_logs/$log_file"

        if [[ ! -f "$active_log_path" ]]; then
            echo "Error: Active log file $active_log_path not found!"
            exit 1
        fi

        if [[ ! -d "$file_dir" ]]; then
            mkdir -p "$file_dir" || { echo "Error: Unable to create archive folder $file_dir"; exit 1; }
        fi

        base_name=$(basename "$log_file" .log)
        archived_log="${base_name}_${timestamp}.log"
        mv "$active_log_path" "$file_dir/$archived_log"
        touch "$active_log_path" || { echo "Error: Unable to create new active log file $active_log_path"; exit 1; }
        echo "Successfully archived to $file_dir/$archived_log"
        ;;

    2)
        file_dir="temperature_data_archive"
        echo "Archiving temperature log ..."
        log_file="${LOG_FILES[2]}"
        active_log_path="hospital_data/active_logs/$log_file"

        if [[ ! -f "$active_log_path" ]]; then
            echo "Error: Active log file $active_log_path not found!"
            exit 1
        fi

        if [[ ! -d "$file_dir" ]]; then
            mkdir -p "$file_dir" || { echo "Error: Unable to create archive folder $file_dir"; exit 1; }
        fi

        base_name=$(basename "$log_file" .log)
        archived_log="${base_name}_${timestamp}.log"
        mv "$active_log_path" "$file_dir/$archived_log" || { echo "Error archiving log file."; exit 1; }
        touch "$active_log_path" || { echo "Error: Unable to create new active log file $active_log_path"; exit 1; }
        echo "Successfully archived to $file_dir/$archived_log"
        ;;

    3)
        file_dir="water_usage_data_archive"
        echo "Archiving water usage log..."
        log_file="${LOG_FILES[3]}"
        active_log_path="hospital_data/active_logs/$log_file"

        if [[ ! -f "$active_log_path" ]]; then
            echo "Error: Active log file $active_log_path not found!"
            exit 1
        fi

        if [[ ! -d "$file_dir" ]]; then
            mkdir -p "$file_dir" || { echo "Error: Unable to create archive folder $file_dir"; exit 1; }
        fi

        base_name=$(basename "$log_file" .log)
        archived_log="${base_name}_${timestamp}.log"
        mv "$active_log_path" "$file_dir/$archived_log" || { echo "Error archiving log file."; exit 1; }
        touch "$active_log_path" || { echo "Error: Unable to create new active log file $active_log_path"; exit 1; }
        echo "Successfully archived to $file_dir/$archived_log"
        ;;

    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

