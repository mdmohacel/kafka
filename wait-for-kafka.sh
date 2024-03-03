#!/bin/bash

# Wait for Kafka to be ready
max_attempts=60
attempt=0
while ! nc -z localhost 9092; do
    echo "Waiting for Kafka to be ready..."
    sleep 5
    attempt=$((attempt + 1))
    if [ $attempt -eq $max_attempts ]; then
        echo "Timed out waiting for Kafka."
        exit 1
    fi
done

echo "Kafka is ready!"
