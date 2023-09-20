#! /bin/bash 

while true; do
	inotifywait -re create,modify,delete dir_to_monitor
	
	echo "$(date)" >> "log_monitoring.txt"
done

