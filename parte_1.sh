#!/bin/bash

#Se crea un bucle para llamar la informacion del proceso.

if [ $# -ne 1 ]; then
  echo "Uso: $0 <PID>"
  exit 1
fi

PID=$1

#Se recibe los dstos que piden del ejercio respecto
nombre_proceso=$(ps -p $PID -o comm=)

pid_proceso=$PID

ppid=$(ps -p $PID -o ppid=)

usuario=$(ps -p $PID -o user=)

cpu_usage=$(ps -p $PID -o %cpu=)

mem_usage=$(ps -p $PID -o %mem=)

estado=$(ps -p $PID -o stat=)

path_ejecutable=$(readlink /proc/$PID/exe)

#Se imprime la informacion que se piden
echo "Nombre del proceso: $nombre_proceso"
echo "ID del proceso: $pid_proceso"
echo "Parent process ID: $ppid"
echo "Usuario propietario: $usuario"
echo "Porcentaje de uso de CPU: $cpu_usage%"
echo "Consumo de memoria: $mem_usage%"
echo "Estado: $estado"
echo "Path del ejecutable: $path_ejecutable"

