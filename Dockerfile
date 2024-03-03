# Use the official Kafka base image
FROM confluentinc/cp-kafka:latest

# Install necessary tools
RUN apt-get update && \
    apt-get install -y netcat

# Copy entry script to the container
COPY entry.sh /usr/bin/entry.sh
RUN chmod +x /usr/bin/entry.sh

# Expose the necessary ports
EXPOSE 9092

# Environment variables for Kafka configuration
ENV KAFKA_ADVERTISED_LISTENERS INSIDE://kafka:9093,OUTSIDE://localhost:9092
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
ENV KAFKA_LISTENERS INSIDE://0.0.0.0:9093,OUTSIDE://0.0.0.0:9092
ENV KAFKA_INTER_BROKER_LISTENER_NAME INSIDE
ENV KAFKA_ZOOKEEPER_CONNECT zookeeper:2181

# Command to start Kafka
CMD ["entry.sh"]
