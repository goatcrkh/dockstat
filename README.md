# dockstat

A lightweight Docker container that counts your containers (Total, Running, Stopped) and exports them as a JSON file for dashboards like **Homepage**, or other custom APIs.

##  Usage

```bash
docker run -d \
  --name dockstat \
  -e CHECK_INTERVAL=300 \
  -e OUTPUT_PATH=/config/index.json \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /your/dashboard/config:/config \
  --restart always \
  elclavel/dockstat:latest
