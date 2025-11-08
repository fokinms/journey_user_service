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

#Curl
RUN apt-get update && apt-get install -y curl

WORKDIR /app
COPY --from=user_builder /app/build/libs/*-SNAPSHOT.jar app.jar

#Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]