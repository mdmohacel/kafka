# Use the confluentinc/cp-zookeeper:latest image as the base
FROM confluentinc/cp-zookeeper:latest

# Set environment variables for Kafka configuration
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_BROKER_ID=1

# Expose the Kafka and Zookeeper ports
EXPOSE 9092 2181

# Copy the script for waiting until Kafka is ready
COPY wait-for-kafka.sh /usr/bin/wait-for-kafka.sh
RUN chmod +x /usr/bin/wait-for-kafka.sh

# Create Kafka topics
CMD ["bash", "-c", "/opt/kafka/bin/kafka-topics.sh --create --topic user_topic --bootstrap-server localhost:9092 && /opt/kafka/bin/kafka-topics.sh --create --topic location_topic --bootstrap-server localhost:9092 && start-kafka.sh"]
