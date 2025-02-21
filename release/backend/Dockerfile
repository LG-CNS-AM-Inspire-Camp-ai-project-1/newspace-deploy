FROM       openjdk:17-slim
WORKDIR    /app
COPY       ./build/libs/newspace-backend-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]