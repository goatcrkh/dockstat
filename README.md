# dockstat

A lightweight Docker container that counts your containers (Total, Running, Stopped) and exports them as a JSON file for dashboards like **Homepage**, or other custom APIs.

##  Usage Docker Run

```bash
docker run -d \
  --name dockstat \
  -e CHECK_INTERVAL=300 \
  -e OUTPUT_PATH=/config/index.json \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /your/dashboard/config:/config \
  --restart always \
  elclavel/dockstat:latest
```

## Usage - Docker Compose
```
services:
  dockstat:
    # The official Docker image you built and pushed to Docker Hub
    image: goatcrkh/dockstat:latest
    container_name: dockstat
    restart: always

    # Environment variables to configure the update frequency and output file location
    environment:
      # Time interval in seconds between each update (Default: 60s)
      - CHECK_INTERVAL=60
      # The internal path inside the container where the JSON file is generated
      - OUTPUT_PATH=/config/docker-status.json

    # Volume mappings to share host resources with the container
    volumes:
      # REQUIRED: Mount the host Docker daemon socket in Read-Only mode to scan container status
      - /var/run/docker.sock:/var/run/docker.sock:ro
      
      # REQUIRED: Change the host path (left side) to your Dashboard's config directory
      # This allows your Homepage dashboard to read the generated JSON file
      - /opt/stacks/homepage/config:/config
```
