# Build stage
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
RUN adduser -h /home/eduar -s /bin/sh -D eduar
WORKDIR /home/eduar

COPY --from=builder /app/target/api_nexo-0.0.1-SNAPSHOT.jar app.jar

RUN chown eduar:eduar app.jar
USER eduar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
