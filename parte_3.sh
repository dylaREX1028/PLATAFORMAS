#!/bin/bash

# Verificacion si ejecuta como argumento
if [ $# -eq 0 ]; then
    echo "Usage: $0 <nombre_ejecutable>"
    exit 1
fi

# Nombre del ejecutable
ejecutable="$1"

# Archivo de log para registrar el consumo de CPU y memoria
log_file="log.txt"

# Generar el gráfico y para proceso
function detener_proceso_y_graficar {
    pkill -f "$ejecutable"  
    gnuplot -persist <<-EOF
        set title "Consumo de CPU y Memoria"
        set xlabel "Tiempo (segundos)"
        set ylabel "Consumo (%)"
        set key outside
        plot "$log_file" using 1 with lines title "CPU", \
             "$log_file" using 2 with lines title "Memoria"
EOF
}

# Ejecutar el ejecutable en segundo plano
./"$ejecutable" &

# Obtencion del PID 
pid=$!

# Monitorear y registrar el consumo de CPU y memoria 
echo "Tiempo (s) CPU (%) Memoria (%)" > "$log_file"
while ps -p "$pid" > /dev/null; do
    timestamp=$(date +"%s")
    cpu_usage=$(ps -p "$pid" -o %cpu | tail -n 1)
    mem_usage=$(ps -p "$pid" -o %mem | tail -n 1)
    echo "$timestamp $cpu_usage $mem_usage" >> "$log_file"
    sleep 1
done

# Detener el proceso y generar el gráfico
detener_proceso_y_graficar

exit 0
