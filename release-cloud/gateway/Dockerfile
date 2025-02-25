FROM       openjdk:17-slim
WORKDIR    /newspace
COPY       ./build/libs/newspace-gateway-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]