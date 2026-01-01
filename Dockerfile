# Use Java 17 runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy built JAR from Maven target folder
COPY target/my-app-1.0.0.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
