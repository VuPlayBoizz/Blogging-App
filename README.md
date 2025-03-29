### Blogging-App

## infra

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


