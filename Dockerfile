# Use the wurstmeister/kafka image as the base
FROM wurstmeister/kafka:latest

# Set environment variables for Kafka configuration
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_BROKER_ID=1

# Expose the Kafka and Zookeeper ports
EXPOSE 9092 2181

# Wait for Kafka to be ready and create Kafka topics
CMD ["bash", "-c", "sleep 10 && /opt/kafka/bin/kafka-topics.sh --create --topic user_topic --bootstrap-server localhost:9092  && /opt/kafka/bin/kafka-topics.sh --create --topic location_topic --bootstrap-server localhost:9092  && start-kafka.sh"]
