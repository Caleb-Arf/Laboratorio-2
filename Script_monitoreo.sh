#! /bin/bash

read -p "Ingrese el nombre de un proceso: " p_name
read -p "Ingrese el comando del proceso: " p_cmd

x=1
while [ $x==1 ];do
	p_info="$(pgrep -l $p_name)"
	if [ $p_info == "" ]
		$p_cmd
		#exit
	fi
done

~    
