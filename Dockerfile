#Build stage
FROM eclipse-temurin:24-jdk-alpine as builder

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts gradlew ./
COPY gradle gradle

RUN ./gradlew dependencies || return 0

COPY src src

RUN  ./gradlew clean build -x test

#Runtime stage
FROM eclipse-temurin:24-jre-alpine

WORKDIR /app
COPY --from=builder /app/build/libs/*-SNAPSHOT.jar app.jar

#Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]