#! /usr/bin/env bash
set -e

JAR_NAME="fabric-server-mc.${MINECRAFT_VERSION}-loader.${FABRIC_LOADER_VERSION}-launcher.${FABRIC_INSTALLER_VERSION}.jar"

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USER=${USER:-"minecraft"}

if [ ! "$(id -u "${USER}")" -eq "$PUID" ]; then usermod -o -u "$PUID" "${USER}" ; fi
if [ ! "$(id -g "${USER}")" -eq "$PGID" ]; then groupmod -o -g "$PGID" "${USER}" ; fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u "${USER}")
User gid:    $(id -g "${USER}")
-----------------------------------
"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading Fabric";
    curl -OJ "https://meta.fabricmc.net/v2/versions/loader/${MINECRAFT_VERSION}/${FABRIC_LOADER_VERSION}/${FABRIC_INSTALLER_VERSION}/server/jar"
fi

echo "Accepting EULA"
echo "eula=true" > eula.txt

chown -R "${USER}":"${USER}" /minecraft

COMMAND="${*:-"cd /minecraft; $(which java) ${JAVA_OPTS} -jar $JAR_NAME nogui"}"

su -l "${USER}" -c "$COMMAND"
