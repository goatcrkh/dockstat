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
