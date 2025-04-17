FROM eclipse-temurin:17-jdk-jammy
LABEL maintainer="ramu0709"

WORKDIR /app

COPY target/maven-web-application.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
