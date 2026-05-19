#!/bin/sh

# Set environment variables with default fallback values
CHECK_INTERVAL=${CHECK_INTERVAL:-300}
OUTPUT_PATH=${OUTPUT_PATH:-/app/index.json}

echo "============================================="
echo " Starting dockstat (Docker Stats Generator) "
echo " Interval : ${CHECK_INTERVAL}s"
echo " Output   : ${OUTPUT_PATH}"
echo "============================================="

while true; do
  # Query the Docker socket for all containers (including stopped ones)
  JSON=$(curl --silent --unix-socket /var/run/docker.sock "http://localhost/containers/json?all=true")

  # Check if the curl command was successful
  if [ $? -eq 0 ]; then
    # Parse container counts from the raw JSON payload
    TOTAL=$(echo "$JSON" | grep -o '"Id"' | wc -l)
    RUNNING=$(echo "$JSON" | grep -o '"State":"running"' | wc -l)
    STOPPED=$((TOTAL - RUNNING))

    # Export the standardized JSON payload to the specified output path
    echo "{\"label\":\"Docker\",\"total\":$TOTAL,\"running\":$RUNNING,\"stopped\":$STOPPED}" > "$OUTPUT_PATH"
    echo "$(date): Stats updated (Total: $TOTAL, Running: $RUNNING, Stopped: $STOPPED)"
  else
    echo "$(date): Error - Cannot connect to Docker socket"
  fi

  # Wait for the next synchronization cycle
  sleep "$CHECK_INTERVAL"
done
