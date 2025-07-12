# Sử dụng image Java 17 nhẹ và phổ biến
FROM openjdk:17-jdk-alpine

# Tạo thư mục làm việc trong container
WORKDIR /app

# Copy file JAR từ host vào container
COPY target/*.jar app.jar

# Expose port (phải trùng với server.port nếu bạn có config)
EXPOSE 8080

# Lệnh chạy app Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
