FROM       openjdk:17-slim
WORKDIR    /newspace
COPY       ./build/libs/newspace-backend-0.0.1-SNAPSHOT.jar app.jar
RUN        mkdir ./uploads
ENTRYPOINT ["java", "-jar", "app.jar"]