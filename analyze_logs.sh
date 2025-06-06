#!/bin/bash

LOG_DIR="hospital_data/active_logs"
REPORT_FILE="hospital_data/reports/analysis_report.txt"

mkdir -p reports

echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate_log.log)"
echo "2) Temperature (temperature_log.log)"
echo "3) Water Usage (water_usage_log.log)"
read -p "Enter choice (1-3): " choice

case $choice in
  1)
    LOG_FILE="$LOG_DIR/heart_rate_log.log"
    LABEL="Heart Rate"
    ;;
  2)
    LOG_FILE="$LOG_DIR/temperature_log.log"
    LABEL="Temperature"
    ;;
  3)
    LOG_FILE="$LOG_DIR/water_usage_log.log"
    LABEL="Water Usage"
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

if [ ! -f "$LOG_FILE" ]; then
  echo "Error: $LOG_FILE not found."
  exit 1
fi

echo "Analyzing $LABEL log..."
{
  echo "---------- Analysis Report ----------"
  echo "Log Type: $LABEL"
  echo "Analyzed On: $(date)"
} >> "$REPORT_FILE"

awk '{ print $2 }' "$LOG_FILE" | sort | uniq | while read device; do
  count=$(grep -c "$device" "$LOG_FILE")
  first_time=$(grep "$device" "$LOG_FILE" | head -1 | awk '{print $1, $2}')
  last_time=$(grep "$device" "$LOG_FILE" | tail -1 | awk '{print $1, $2}')
  {
    echo "Device: $device"
    echo "  Total entries: $count"
    echo "  First entry: $first_time"
    echo "  Last entry: $last_time"
  } >> "$REPORT_FILE"
done

echo "Analysis complete. Report saved to $REPORT_FILE"
