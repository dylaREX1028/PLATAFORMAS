#!/bin/bash

# Verifica si se recibe datos correctos
if [ $# -ne 2 ]; then
  echo "Uso: $0 <nombre_del_proceso> <comando_de_inicio>"
  exit 1
fi

nombre_proceso="$1"
comando_inicio="$2"


# Ejecución del proceso
while true; do
  
    if ! pgrep -x "$nombre_proceso" > /dev/null; then
    echo "El proceso $nombre_proceso no está en ejecución. Reiniciando..."
    
    # Comando de inicio
    $comando_inicio &
    
    # Tiempo antes de volver a verificar el estado del proceso
    sleep 4
    
  else
    echo "El proceso $nombre_proceso está en ejecución."
    
    # Otra vez, tiempo antes de volver a verificar el estado del proceso
    sleep 45 
  fi
done
