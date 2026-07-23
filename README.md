# Enterprise Cloud Platform

![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4)
![Java](https://img.shields.io/badge/Java-Spring%20Boot-6DB33F)
![Docker](https://img.shields.io/badge/Docker-Container-2496ED)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF)


## Overview

The **Enterprise Cloud Platform** is a production-style cloud infrastructure project that demonstrates modern DevOps practices using AWS, Terraform, Docker, Java Spring Boot, ECS Fargate, PostgreSQL RDS, and GitHub Actions.

The objective of this project is to design, deploy, and manage a scalable, secure, highly available, and cost-effective cloud platform using Infrastructure as Code (IaC) and CI/CD automation.

---

# Architecture

```text
                        Users
                          │
                          ▼
              Application Load Balancer
                          │
                          ▼
                  ECS Fargate Service
                          │
                          ▼
              Java Spring Boot Application
                          │
                          ▼
                  PostgreSQL RDS Database


Deployment Pipeline

Developer
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Checkout Source
    ├── Maven Build
    ├── Docker Build
    ├── Push Image to Amazon ECR
    └── Deploy ECS Service
```

---

# Features

- Infrastructure as Code with Terraform
- Java Spring Boot REST API
- Docker containerization
- Amazon ECS Fargate deployment
- Amazon ECR image registry
- PostgreSQL RDS database
- Application Load Balancer
- GitHub Actions CI/CD
- CloudWatch monitoring
- AWS Secrets Manager integration
- Secure VPC networking
- Private database architecture

---

# Technology Stack

| Category | Technology |
|-----------|------------|
| Cloud Provider | AWS |
| Infrastructure as Code | Terraform |
| Programming Language | Java 17 |
| Framework | Spring Boot |
| Build Tool | Maven |
| Containerization | Docker |
| Container Orchestration | Amazon ECS Fargate |
| Container Registry | Amazon ECR |
| Database | PostgreSQL (Amazon RDS) |
| CI/CD | GitHub Actions |
| Monitoring | Amazon CloudWatch |
| Secrets Management | AWS Secrets Manager |
| Version Control | GitHub |

---

# AWS Infrastructure

## Networking

```
AWS Region

└── VPC
    │
    ├── Public Subnets
    │     │
    │     ├── Application Load Balancer
    │     └── NAT Gateway
    │
    └── Private Subnets
          │
          ├── ECS Fargate Tasks
          └── PostgreSQL RDS
```

---

# Infrastructure Components

## VPC

The platform is deployed inside a dedicated Virtual Private Cloud that isolates resources from other AWS environments.

---

## Public Subnets

Public subnets contain:

- Application Load Balancer
- NAT Gateway

These resources are accessible from the internet.

---

## Private Subnets

Private subnets contain:

- ECS Fargate Tasks
- PostgreSQL Database

No direct internet access is allowed.

---

## Application Load Balancer

The Application Load Balancer:

- Routes incoming traffic
- Performs health checks
- Distributes requests across ECS tasks
- Improves application availability

---

## Amazon ECS Fargate

The Spring Boot application runs inside Docker containers managed by ECS Fargate.

Benefits:

- No EC2 management
- Automatic scaling
- High availability
- Pay only for resources used

---

## Amazon ECR

Docker images are stored securely inside Amazon Elastic Container Registry before deployment.

---

## Amazon RDS

PostgreSQL provides persistent application data storage.

Features include:

- Automated backups
- Encryption at rest
- Performance Insights
- Enhanced Monitoring
- Private networking

---

# Application

The backend application is built using **Spring Boot**.

Example endpoint:

```http
GET /
```

Response

```
Enterprise Cloud Platform Running
```

Health endpoint

```http
GET /health
```

Response

```
healthy
```

The health endpoint is used by the Application Load Balancer to verify container health.

---

# Docker

The application is packaged into a Docker image.

Build flow

```
Spring Boot Application
        │
        ▼
 Maven Package
        │
        ▼
   JAR File
        │
        ▼
 Docker Image
        │
        ▼
 Amazon ECR
        │
        ▼
 ECS Fargate
```

---

# CI/CD Pipeline

GitHub Actions automatically deploys every change pushed to the `main` branch.

Pipeline stages:

1. Checkout source code
2. Setup Java
3. Build application using Maven
4. Run tests
5. Build Docker image
6. Authenticate to Amazon ECR
7. Push Docker image
8. Update ECS service

Pipeline workflow:

```
Developer

    │

Git Push

    │

GitHub Actions

    │

Maven Build

    │

Docker Build

    │

Amazon ECR

    │

Amazon ECS

    │

Production Deployment
```

---

# Monitoring

CloudWatch provides operational visibility.

## ECS Metrics

- CPU Utilization
- Memory Utilization
- Task Status
- Container Logs

---

## RDS Metrics

- CPU Usage
- Database Connections
- Storage Usage
- Read IOPS
- Write IOPS
- Query Performance

---

## ALB Metrics

- Request Count
- Target Response Time
- HTTP 4XX Errors
- HTTP 5XX Errors
- Healthy Targets

---

# Security

The project follows AWS security best practices.

Implemented controls include:

- Private subnets
- Security Groups
- IAM Roles
- Secrets Manager
- Encrypted RDS
- No hardcoded credentials
- Application Load Balancer health checks
- Least privilege access

---

# Project Structure

```
enterprise-cloud-platform/

├── app/
│   ├── src/
│   ├── pom.xml
│   ├── Dockerfile
│   └── .dockerignore
│
├── terraform/
│   ├── modules/
│   │   ├── networking/
│   │   ├── security/
│   │   ├── alb/
│   │   ├── ecs/
│   │   ├── ecr/
│   │   ├── rds/
│   │   ├── secrets/
│   │   └── monitoring/
│   │
│   ├── backend.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── main.tf
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── README.md
└── LICENSE
```

---

# Deployment

## Clone Repository

```bash
git clone https://github.com/<your-username>/enterprise-cloud-platform.git

cd enterprise-cloud-platform
```

---

## Deploy Infrastructure

```bash
cd terraform

terraform init

terraform validate

terraform plan

terraform apply
```

---

## Build Application

```bash
cd app

mvn clean package
```

---

## Run Locally

```bash
docker build -t enterprise-cloud-app .

docker run -p 3000:3000 enterprise-cloud-app
```

Application:

```
http://localhost:3000
```

Health endpoint:

```
http://localhost:3000/health
```

---

# Future Improvements

I plan to enhance this project with:

- Jenkins CI/CD
- HTTPS with ACM
- Route53 custom domain
- AWS WAF
- Terraform Cloud
- Blue/Green deployments
- Auto Scaling Policies
- SNS Alert Notifications
- Security scanning (Checkov / tfsec)
- Multi-region disaster recovery

---

# Learning Objectives

This project demonstrates practical experience with:

- AWS Cloud Architecture
- Infrastructure as Code
- Containerization
- CI/CD Automation
- Cloud Security
- Monitoring & Observability
- DevOps Best Practices
- Production Deployment
- Enterprise Networking

---

#  Project Summary

**Enterprise Cloud Platform**

I Designed and deployed a production-grade cloud platform on AWS using Terraform, ECS Fargate, Docker, Java Spring Boot, PostgreSQL RDS, and GitHub Actions. Implemented Infrastructure as Code, automated CI/CD pipelines, secure networking, container orchestration, centralized monitoring with CloudWatch, and secrets management following enterprise DevOps best practices.

---

