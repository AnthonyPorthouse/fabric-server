ARG JAVA_VERSION=17

FROM eclipse-temurin:${JAVA_VERSION}

RUN adduser --disabled-password --uid 1000 --shell /bin/bash --gecos "" minecraft \
    && addgroup minecraft users

EXPOSE 25565

WORKDIR /minecraft

ENV MINECRAFT_VERSION=1.20.2
ENV FABRIC_LOADER_VERSION=0.14.24
ENV FABRIC_INSTALLER_VERSION=0.11.2

ENV JAVA_OPTS="-Xms1G -Xmx2G"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
