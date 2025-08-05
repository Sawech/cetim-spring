# Step 1: Build the JAR inside a Maven container
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml first for dependency caching
COPY pom.xml .

# Download dependencies (faster builds because this step is cached)
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Build the application without running tests
RUN mvn clean package -DskipTests

# Step 2: Run the JAR in a slim Java container
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/labs-0.0.1-SNAPSHOT.jar app.jar

# Expose Spring Boot's default port
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
