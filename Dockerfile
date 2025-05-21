# Stage 1: Build the WAR file using Maven
FROM maven:3.8.7-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Use Tomcat to run the WAR
FROM tomcat:9.0-jdk17-openjdk

# Clean default webapp and deploy our WAR
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
# Note: The WAR file is deployed as ROOT.war, so it will be accessible at http://localhost:8080/