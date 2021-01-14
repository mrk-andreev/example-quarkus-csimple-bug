FROM maven:3.6.3-jdk-11 AS builder
WORKDIR /opt/app
COPY . /opt/app
RUN mvn package -DskipTests
