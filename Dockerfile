# Stage 1: Build the WAR file using Maven
FROM maven:3.8.7-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy the entire project and build
COPY . .
RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Use Tomcat base image to deploy the WAR
FROM tomcat:9.0-jdk17-openjdk

# Remove default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy our built WAR as ROOT.war
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
