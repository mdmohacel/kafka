# Use the wurstmeister/kafka image as the base
FROM wurstmeister/kafka:2.8.0

# Set environment variables for Kafka configuration
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092,http://localhost:8082
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,http:PLAINTEXT
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
ENV KAFKA_BROKER_ID=1

# Expose the Kafka, Zookeeper, and Kafka REST Proxy ports
EXPOSE 9092 2181 8082

# Copy the script for waiting until Kafka is ready
COPY wait-for-kafka.sh /usr/bin/wait-for-kafka.sh
RUN chmod +x /usr/bin/wait-for-kafka.sh

# Install Kafka REST Proxy
RUN curl -LJO https://github.com/confluentinc/kafka-rest/archive/refs/tags/v6.1.1.tar.gz \
    && tar -xzvf kafka-rest-6.1.1.tar.gz \
    && mv kafka-rest-6.1.1 /opt/kafka-rest \
    && rm kafka-rest-6.1.1.tar.gz

# Wait for Kafka to be ready, create Kafka topics, and start Kafka and Kafka REST Proxy
CMD ["bash", "-c", "/usr/bin/wait-for-kafka.sh && /opt/kafka/bin/kafka-topics.sh --create --topic location --bootstrap-server localhost:9092 && /opt/kafka/bin/kafka-topics.sh --create --topic user --bootstrap-server localhost:9092 && /opt/kafka-rest/bin/kafka-rest-start /opt/kafka-rest/etc/kafka-rest/kafka-rest.properties && start-kafka.sh"]
