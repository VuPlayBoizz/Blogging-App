FROM eclipse-temurin:17-jdk-alpine AS builder

# Định nghĩa thư mục làm việc
WORKDIR /usr/src/app

# Copy toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng
RUN ./mvnw clean package -DskipTests

# Stage chạy ứng dụng
FROM eclipse-temurin:17-jre-alpine AS runtime

# Định nghĩa thư mục làm việc
WORKDIR /usr/src/app

# Copy file JAR từ stage build
COPY --from=builder /usr/src/app/target/*.jar app.jar

# Expose cổng ứng dụng
EXPOSE 8080

# Chạy ứng dụng
CMD ["java", "-jar", "app.jar"]
