FROM alpine:latest

# Install lightweight dependencies required for parsing
RUN apk add --no-cache curl docker-cli python3 bash

WORKDIR /app

# Copy the entrypoint script and grant execution permissions
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Define default environment variables for international deployment
ENV CHECK_INTERVAL=60

# API Port
EXPOSE 8080

# Define the container startup command
ENTRYPOINT ["./entrypoint.sh"]
