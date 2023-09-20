#!/bin/bash

get_name(){
        name="$(cat /proc/$1/comm)"
        echo "Process name: $name"
        }

get_info(){
        items="pid ppid user pcpu pmem state"
        for i in $items; do
                pid="$(ps -p $1 -o $i)"

                for item in $pid; do
                        name="$item"
                done
                echo "$i: $name"
        done
        }
get_path(){
        path="$(ps -p $1 -o cmd | awk '{print $1}')"
        path=${path/CMD}
        echo "path: $path"
        }


read -p "Ingrese el ID de un proceso: " id_given

id_list="$(ps -ef | awk '{print $2}')"

for id in $id_list; do
	if [ "$id" == "$id_given" ]; then
		get_name $id_given
		get_info $id_given
		get_path $id_given
		exit
	fi
done

echo "No existe proceso con ese ID"
exit



