#! /usr/bin/env bash
set -e

JAR_NAME="fabric-server-mc.${MINECRAFT_VERSION}-loader.${FABRIC_LOADER_VERSION}-launcher.${FABRIC_INSTALLER_VERSION}.jar"

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USER=${USER:-"minecraft"}

set-up-user.sh "$USER" "$PUID" "$PGID"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading Fabric";
    curl -OJ "https://meta.fabricmc.net/v2/versions/loader/${MINECRAFT_VERSION}/${FABRIC_LOADER_VERSION}/${FABRIC_INSTALLER_VERSION}/server/jar"
fi

echo "Accepting EULA"
echo "eula=true" > eula.txt

configure-server-properties.sh

chown -R "${USER}":"${USER}" /minecraft

COMMAND="${*:-"cd /minecraft; $(which java) ${JAVA_OPTS} -jar $JAR_NAME nogui"}"

su -l "${USER}" -c "$COMMAND"
