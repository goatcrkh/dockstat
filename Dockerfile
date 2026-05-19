FROM alpine:latest

# Install lightweight dependencies required for parsing
RUN apk add --no-cache curl grep

WORKDIR /app

# Copy the entrypoint script and grant execution permissions
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Define default environment variables for international deployment
ENV CHECK_INTERVAL=300
ENV OUTPUT_PATH=/app/index.json

# Define the container startup command
ENTRYPOINT ["./entrypoint.sh"]
