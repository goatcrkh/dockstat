#!/bin/sh

# Set environment variables with default fallback values
CHECK_INTERVAL=${CHECK_INTERVAL:-60}
OUTPUT_PATH=${OUTPUT_PATH:-/app/index.json}

echo '{"label":"Docker","total":0,"running":0,"stopped":0}' > "$OUTPUT_PATH"

python3 -m http.server 8080 --directory /app &

echo "============================================="
echo " Starting dockstat API Server "
echo " Interval : ${CHECK_INTERVAL}s"
echo " API URL  : http://[Host-IP]:8080/index.json"
echo "============================================="

while true; do
  JSON=$(curl --silent --unix-socket /var/run/docker.sock "http://localhost/containers/json?all=true")

  if [ $? -eq 0 ]; then
    TOTAL=$(echo "$JSON" | grep -o '"Id"' | wc -l)
    RUNNING=$(echo "$JSON" | grep -o '"State":"running"' | wc -l)
    STOPPED=$((TOTAL - RUNNING))

    echo "{\"label\":\"Docker\",\"total\":$TOTAL,\"running\":$RUNNING,\"stopped\":$STOPPED}" > "$OUTPUT_PATH"
    echo "$(date): Stats updated (Total: $TOTAL, Running: $RUNNING, Stopped: $STOPPED)"
  else
    echo "$(date): Error - Cannot connect to Docker socket"
  fi

  sleep "$CHECK_INTERVAL"
done
