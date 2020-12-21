FROM maven:3.5.2-jdk-8-alpine AS MAVEN
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

#FROM openjdk:8
FROM openjdk:8-jdk-alpine
COPY --from=MAVEN /tmp/target/*.jar app.jar
EXPOSE 8080
# add == mv
#ADD target/*.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
#ENTRYPOINT ["sh", "-c", "java -jar app.jar"]
# ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=container","-jar","/app.jar"]
