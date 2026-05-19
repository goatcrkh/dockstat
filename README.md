# dockstat

A lightweight Docker container that counts your containers and provides a real-time JSON API via an internal HTTP server (Port 8080).

##  Usage Docker Run

```bash
docker run -d \
  --name dockstat \
  -p 8080:8080 \
  -e CHECK_INTERVAL=60 \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --restart always \
  elclavel/dockstat:latest
```

## Usage - Docker Compose
```
services:
  dockstat:
    image: elclavel/dockstat:latest
    container_name: dockstat
    restart: always
    environment:
      - CHECK_INTERVAL=60  # Update frequency in seconds
    ports:
      - "8080:8080"        # API Port
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
```

# API Endpoint

Once the container is running, you can access the container stats at:

http://[YOUR-SERVER-IP]:8080/index.json

## Output Format
```json
{
  "label": "Docker",
  "total": 5,
  "running": 4,
  "stopped": 1
}
```

# Integration: Homepage Dashboard
To display these stats on your Homepage dashboard, use the customapi widget in your 

services.yaml:

```yaml
- Docker Status:
    icon: docker.png
    widget:
        type: customapi
        url: http://[YOUR-SERVER-IP]:8080/index.json
        refreshInterval: 60000
        method: get
        mappings:
          - field: total
            label: Total
          - field: running
            label: Running
          - field: stopped
            label: Stopped
```
