FROM eclipse-temurin:17-jdk-alpine

LABEL maintainer="ramu0709"

ARG JAR_FILE=target/maven-web-application-0.0.1-SNAPSHOT.jar

COPY ${JAR_FILE} app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app.jar"]
