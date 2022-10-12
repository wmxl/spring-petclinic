# syntax=docker/dockerfile:1

FROM openjdk:8-jdk-alpine as base
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
# maven setting (ali mirror)
COPY settings.xml ./
# 指定settiings文件(用ali镜像, 加快解决依赖时的速度)
RUN ./mvnw dependency:resolve -s ./settings.xml

COPY src ./src

FROM base as test
CMD ["./mvnw", "test", "-s", "./settings.xml"]
#RUN ["./mvnw", "test", "-s", "./settings.xml"]

FROM base as development
CMD ["./mvnw", "spring-boot:run", "-s", "./settings.xml", "-Dspring-boot.run.jvmArguments='-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000'"]

FROM base as build
RUN ./mvnw package

FROM openjdk:8-jre-alpine as production
EXPOSE 8080
COPY --from=build /app/target/spring-petclinic-*.jar /spring-petclinic.jar
#CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=mysql", "-jar", "/spring-petclinic.jar"]
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]
