# Hello World Rest API

### Building an Image

1. Build a Jar - /target/hello-world-rest-api.jar
2. Setup the Prerequisites for Running the JAR - openjdk:8-jdk-alpine
3. Copy the jar
4. Run the jar



## Docker File

### Basic
```
FROM openjdk:8-jdk-alpine
EXPOSE 8080
ADD target/hello-world-rest-api.jar hello-world-rest-api.jar
ENTRYPOINT ["sh", "-c", "java -jar /hello-world-rest-api.jar"]
```

### Level 2

```
FROM openjdk:8-jdk-alpine
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","com.in28minutes.rest.webservices.restfulwebservices.RestfulWebServicesApplication"]
```

## Plugins

### Dockerfile Maven

- From Spotify
- https://github.com/spotify/dockerfile-maven

```
<plugin>
	<groupId>com.spotify</groupId>
	<artifactId>dockerfile-maven-plugin</artifactId>
	<version>1.4.10</version>
	<executions>
		<execution>
			<id>default</id>
			<goals>
				<goal>build</goal>
			</goals>
		</execution>
	</executions>
	<configuration>
		<repository>in28min/${project.name}</repository>
		<tag>${project.version}</tag>
		<skipDockerInfo>true</skipDockerInfo>
	</configuration>
</plugin>
```
### JIB

- https://github.com/GoogleContainerTools/jib/tree/master/jib-maven-plugin#quickstart

- https://github.com/GoogleContainerTools/jib/blob/master/docs/faq.md

#### "useCurrentTimestamp - true" discussion
- https://github.com/GooleContainerTools/jib/blob/master/docs/faq.md#why-is-my-image-created-48-years-ago 
- https://github.com/GoogleContainerTools/jib/issues/413 

```
<plugin>
	<groupId>com.google.cloud.tools</groupId>
	<artifactId>jib-maven-plugin</artifactId>
	<version>1.6.1</version>
	<configuration>
		<container>
			<creationTime>USE_CURRENT_TIMESTAMP</creationTime>
		</container>
	</configuration>
	<executions>
		<execution>
			<phase>package</phase>
			<goals>
				<goal>dockerBuild</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```
```
<configuration>
	<from>
		<image>openjdk:alpine</image>
	</from>
	<to>
		<image>in28min/${project.name}</image>
		<tags>
			<tag>${project.version}</tag>
			<tag>latest</tag>
		</tags>
	</to>
	<container>
		<jvmFlags>
			<jvmFlag>-Xms512m</jvmFlag>
		</jvmFlags>
		<mainClass>com.in28minutes.rest.webservices.restfulwebservices.RestfulWebServicesApplication</mainClass>
		<ports>
			<port>8100</port>
		</ports>
	</container>
</configuration>
```

### fabric8io/docker-maven-plugin

- https://dmp.fabric8.io/
- Remove Spotify Maven and JIB Plugins. Add the plugin shown below and configure property for jar file.

Supports 
 - Dockerfile
 - Defining Dockerfile contents in POM XML. 

#### Using Dockerfile

```
<!-- To build the image - "mvn clean package" -->
<!-- Successfully tagged webservices/01-hello-world-rest-api -->
<!-- docker run -p 8080:8080 webservices/01-hello-world-rest-api -->
<plugin>
	<groupId>io.fabric8</groupId>
	<artifactId>docker-maven-plugin</artifactId>
	<version>0.26.0</version>
	<executions>
		<execution>
			<id>docker-build</id>
			<phase>package</phase>
			<goals>
				<goal>build</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

```
<properties>
...
 <jar>${project.build.directory}/${project.build.finalName}.jar</jar>
</properties>
```

#### Using XML Configuration

```
<!-- To build the image - "mvn clean package" -->
<!-- TAG - 01-hello-world-rest-api:latest -->
<!-- docker run -p 8080:8080 01-hello-world-rest-api:latest -->
<plugin>
   <groupId>io.fabric8</groupId>
   <artifactId>docker-maven-plugin</artifactId>
   <version>0.26.0</version>
   <extensions>true</extensions>
   <configuration>
      <verbose>true</verbose>
      <images>
         <image>
            <name>${project.artifactId}</name>
            <build>
               <from>java:8-jdk-alpine</from>
               <entryPoint>
                  <exec>
                     <args>java</args>
                     <args>-jar</args>
                     <args>/maven/${project.build.finalName}.jar</args>
                  </exec>
               </entryPoint>
               <assembly>
                  <descriptorRef>artifact</descriptorRef>
               </assembly>
            </build>
         </image>
      </images>
   </configuration>
   <executions>
	<execution>
		<id>docker-build</id>
		<phase>package</phase>
		<goals>
			<goal>build</goal>
		</goals>
	</execution>
   </executions>
</plugin>
 ```
 
### Maven Dependency Plugin

```
<plugin>	
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-dependency-plugin</artifactId>
	<executions>
		<execution>
			<id>unpack</id>
			<phase>package</phase>
			<goals>
				<goal>unpack</goal>
			</goals>
			<configuration>
				<artifactItems>
					<artifactItem>
						<groupId>${project.groupId}</groupId>
						<artifactId>${project.artifactId}</artifactId>
						<version>${project.version}</version>
					</artifactItem>
				</artifactItems>
			</configuration>
		</execution>
	</executions>
</plugin>
```
 

### Improve Caching of Images using Layers
 
#### CURRENT SITUATION					

			--------------- 
			    FAT JAR
			--------------- 
			      JDK
			--------------- 

####  DESIRED SITUATION
			--------------- 
			    CLASSES   
			---------------
			 DEPENDENCIES 
			---------------
			     JDK      
			---------------
 
 
 
 
 
 
 
 
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> my recommandation <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 use the maven docker as temperory  step then copy the result (app.jar) into another container to such as a openjdk:8-jdk-alpine then run the app.jar
 
 
 # >>>> for example: 
 
 ```
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

```
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
#  ---------------------------------- for many senarios and examples ------------------------------------------------------------
 
#FROM openjdk:8
#VOLUME /tmp
#ADD target/springboot-docker-compose.jar springboot-docker-compose.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","springboot-docker-compose.jar"]

#FROM openjdk:8-jdk-alpine
#VOLUME /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]


#FROM openjdk:8-jdk-alpine
#VOLUME /tmp
#COPY target/spring-boot-docker-*.jar app.jar
#ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]

#FROM openjdk:8-jdk-alpine
#VOLUME /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

## Start with a base image containing Java runtime
#FROM openjdk:8-jdk-alpine
#
## Add Maintainer Info
#LABEL maintainer="callicoder@gmail.com"
#
## Add a volume pointing to /tmp
#VOLUME /tmp
#
## Make port 8080 available to the world outside this container
#EXPOSE 8080
#
## The application's jar file
#ARG JAR_FILE=target/spring-boot-docker-0.0.1-SNAPSHOT.jar
#
## Add the application's jar to the container
#ADD ${JAR_FILE} spring-boot-docker.jar
#
## Run the jar file
#ENTRYPOINT ["java","-jar","spring-boot-docker.jar"]



# Example
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
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=container","-jar","/app.jar"]
 
