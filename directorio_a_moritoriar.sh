#!/bin/bash

# Ruta del directorio 
directory_to_monitor="/home/dylanna/lab1_C06660"

# Ruta del archivo de registro
log_file="/var/log/directory_monitor.log"

# Bucle de inotifywait
inotifywait -m -e create,modify,delete "$directory_to_monitor" |
while read -r directory event file
do
    # Fecha y hora actual
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Imprime el evento en el archivo
    echo "[$timestamp] Evento en $directory: $event $file" >> "$log_file"
done
