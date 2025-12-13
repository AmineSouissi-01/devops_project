FROM eclipse-temurin:8-jdk
EXPOSE 8082
ADD target/timesheet-devops-1.0.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]