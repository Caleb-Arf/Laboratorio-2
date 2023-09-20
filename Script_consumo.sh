#!/bin/bash


#recibe como entrada el nombre de un ejecutable
read -p "Ingrese un ejecutable: " exe_given


#abre el ejecutable en segundo plano para poder monitorearlo
exe="$(readlink -f $exe_given)"
"$exe" &


#obtiene el pid para obtener el pcpu y el pmem
exe_id="$(pgrep $exe_given)"


#obtiene los datos verificando el estado del ejecutable 
check_id=0

while [ $check_id == 0 ];do
        cpu="pcpu="
        mem="pmem="

        #Obtener los porcentajes de consumo y el tiempo
        p_cpu="$(ps -p $exe_id -o $cpu)"
        p_mem="$(ps -p $exe_id -o $mem)"
        time="$(date +%H):$(date +%M):$(date +%S)"

        #Revisar si las entradas de consumo tienen informacion, si no tienen significa que el proceso del ejecutable cerro       
        if [ "$p_cpu" == "" ] || [ "$p_mem" == "" ];then
                #si el proceso cerro, el script deja de verificar el estado del ejecutable
                check_id=$(( $check_id + 1))
        else
                #si las entradas tienen informacion la pasan al log
                echo "$p_cpu    $p_mem  $time" >> "log_monitoreo_consumo.txt"
        fi
        #esperar un segundo para volver a leer 
        sleep 1
done
