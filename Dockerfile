FROM maven:3.5.4 as builder

COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package -Dmaven.test.skip=true 

FROM openjdk:8-jre-alpine

ENTRYPOINT ["sh", "/start-app.sh"]

RUN mkdir -p config 

COPY start-app.sh start-app.sh

COPY contrast_security.yaml contrast_security.yaml
COPY contrast.jar contrast.jar

COPY --from=builder /tmp/target/sprint-boot-contrast-0.0.1-SNAPSHOT.jar sprint-boot-contrast.jar
