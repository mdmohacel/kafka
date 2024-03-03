# Use the wurstmeister/kafka image as the base
FROM wurstmeister/kafka:latest

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

# Wait for Kafka to be ready, create Kafka topics, and start Kafka
CMD ["bash", "-c", "/usr/bin/wait-for-kafka.sh && /opt/kafka/bin/kafka-topics.sh --create --topic location --bootstrap-server localhost:9092 && /opt/kafka/bin/kafka-topics.sh --create --topic user --bootstrap-server localhost:9092 && start-kafka.sh"]
