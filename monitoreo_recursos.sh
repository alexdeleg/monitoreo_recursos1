
# guardado en recusos.txt
guardado="recursos.txt"
echo -e "Tiempo\t% CPU Libre\t% Memoria Libre\t% Disco Libre">"$guardado"
duracion=300
intervalos=60
tiempo=0


while [ $tiempo -le $duracion ]; do
 cpu_libre=$(top -bn1 | grep "Cpu(s)" | awk '{print 100- $8}')
 memorialibre=$(free | grep "Mem:" | awk '{print ($4 + $6) / $2 * 100}')
 discolibre=$(df -h / | awk 'NR==2 {print $4}' | sed 's/%//')

 # mostrar  todo los nesesario para el monitoreo
  echo -e "${tiempo}s\t$cpu_libre\t$memorialibre\t$discolibre" >> "$guardado"

  # los 60 segundos controlados por el comando sleep
  sleep $intervalos
  tiempo=$((tiempo + intervalos))
done
#mensaje al completar los 5 min de monitoreo
echo "monitoreo competado resultados guardados en $guardado"
