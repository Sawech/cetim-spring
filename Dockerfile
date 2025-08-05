# Use Java 17
FROM eclipse-temurin:17-jdk

# Create app directory inside container
WORKDIR /app

# Copy the built jar from your local machine into the container
COPY target/labs-0.0.1-SNAPSHOT.jar app.jar

# Expose the port Spring Boot runs on
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
