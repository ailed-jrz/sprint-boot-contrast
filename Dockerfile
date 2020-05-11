FROM maven:3.5.4 as builder

COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package -Dmaven.test.skip=true 

FROM openjdk:8

ENTRYPOINT ["bash", "/app/start-app.sh"]

RUN mkdir -p /app 
WORKDIR /app

COPY start-app.sh start-app.sh

COPY contrast_security.yaml contrast_security.yaml
COPY contrast.jar contrast.jar

COPY threaddump_linux.sh /app/debug/threaddump_linux.sh
RUN /bin/chmod 755 /app/debug/threaddump_linux.sh

COPY --from=builder /tmp/target/sprint-boot-contrast-0.0.1-SNAPSHOT.jar sprint-boot-contrast.jar
