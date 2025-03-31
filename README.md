### Blogging-App
![Screenshot 2025-03-28 224507](https://github.com/user-attachments/assets/4c3017aa-c50a-4880-bb0d-63dc1be5d20b)
![Screenshot 2025-03-28 224457](https://github.com/user-attachments/assets/a7c2f9d7-0c41-4000-b174-e862ecbabd53)

## /infra
![Biểu đồ không có tiêu đề](https://github.com/user-attachments/assets/dab9c381-ca78-41c6-93bd-c819943bb3d1)

## /src
# Twitter App - Spring Boot Application

## Overview
This project is a simple Twitter-like application built using **Spring Boot**. It provides functionalities such as user authentication, posting tweets, and retrieving user and post data via REST APIs.

## Features
- User authentication and authorization using Spring Security
- RESTful APIs for managing users and posts
- Data persistence using **Spring Data JPA** and **RDS Database** (or replaceable with MySQL/PostgreSQL)
- Secure access with JWT-based authentication
- Modular structure following MVC pattern

## Project Structure
```
src/main/java/com/example/twitterapp/
├── config/            # Security and application configurations
├── controller/        # API controllers handling HTTP requests
├── model/             # Entity models for Users and Posts
├── repository/        # Database access layer
├── service/           # Business logic layer
├── TwitterAppApplication.java  # Main entry point for Spring Boot
```

## Technologies Used
- **Spring Boot** - Core framework
- **Spring Security** - Authentication and authorization
- **Spring Data JPA** - ORM for database interactions
- **JWT** - Token-based authentication
- **RDS MYSQL** - Database options
- **Lombok** - Reduces boilerplate code
- **Swagger** - API documentation

## API Endpoints
| Method | Endpoint             | Description |
|--------|----------------------|-------------|
| POST   | `/api/auth/register` | User registration |
| POST   | `/api/auth/login`    | User login (returns JWT) |
| GET    | `/api/users/{id}`    | Get user details |
| POST   | `/api/posts`         | Create a new post |
| GET    | `/api/posts`         | Retrieve all posts |

## /CI-CD Pipeline
![pictutr](https://github.com/user-attachments/assets/775aad1d-7c43-48b6-9c07-c8049bdf0374)

