#Build stage
FROM eclipse-temurin:24-jdk-alpine as user_builder

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts gradlew ./
COPY gradle gradle

RUN ./gradlew dependencies || return 0
RUN apk add --no-cache curl

COPY src src

RUN  ./gradlew clean build -x test

#Runtime stage
FROM eclipse-temurin:24-jre-alpine

WORKDIR /app
COPY --from=user_builder /app/build/libs/*-SNAPSHOT.jar app.jar

#Healthcheck
COPY health-check.sh /usr/local/bin/health-check.sh
RUN chmod +x /usr/local/bin/health-check.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD /usr/local/bin/health-check.sh

#Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]