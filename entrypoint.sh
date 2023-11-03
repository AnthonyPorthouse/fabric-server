#! /usr/bin/env sh

JAR_NAME="fabric-server-mc.${MINECRAFT_VERSION}-loader.${FABRIC_LOADER_VERSION}-launcher.${FABRIC_INSTALLER_VERSION}.jar"

if [ ! -f "$JAR_NAME" ]; then
    echo "Downloading Fabric";
    curl -OJ "https://meta.fabricmc.net/v2/versions/loader/${MINECRAFT_VERSION}/${FABRIC_LOADER_VERSION}/${FABRIC_INSTALLER_VERSION}/server/jar"
fi

echo "Accepting EULA"
echo "eula=true" > eula.txt

java ${JAVA_OPTS} -jar "$JAR_NAME" nogui