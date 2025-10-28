#Build stage
FROM eclipse-temurin:24-jdk as user_builder

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts gradlew ./
COPY gradle gradle

RUN ./gradlew dependencies || return 0

COPY src src

RUN  ./gradlew clean build -x test

#Runtime stage
FROM eclipse-temurin:24-jre

#If i need same time with dev machine
RUN ln -snf /usr/share/zoneinfo/Asia/Dubai /etc/localtime && echo "Asia/Dubai" > /etc/timezone
ENV TZ=Asia/Dubai

#Curl for health-check script
RUN apt-get update && apt-get install -y curl

WORKDIR /app
COPY --from=user_builder /app/build/libs/*-SNAPSHOT.jar app.jar

#Healthcheck
COPY health-check.sh /usr/local/bin/health-check.sh
RUN chmod +x /usr/local/bin/health-check.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD /usr/local/bin/health-check.sh

#Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]