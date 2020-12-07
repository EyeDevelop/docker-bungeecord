#!/bin/bash

if [[ -z "$(id mcuser 2>/dev/null)" ]]; then
    addgroup -g "${PGID}" mcuser
    adduser -H -D -G mcuser -u "${PUID}" mcuser
fi

if [[ ! -d "/server" ]]; then
    mkdir -p /server
    chown -R mcuser:mcuser /server
fi

if [[ ! -f "/server/spigot.jar" ]]; then
    echo "Building/compiling Spigot..."

    mkdir -p /tmp/buildtools
    curl -L -o "/tmp/buildtools/buildtools.jar" "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
    java -jar /tmp/buildtools/buildtools.jar --output-dir /server --rev "${MC_VERSION}" >/dev/null 2>&1

    mv "/server/spigot-${MC_VERSION}.jar" "/server/spigot.jar"
fi

if [[ ! -f "/server/eula.txt" ]]; then
    echo "IF YOU DO NOT AGREE WITH THE MINECRAFT SERVER EULA, STOP HERE."
    echo "Auto-accepting the EULA..."
    echo "eula=true" > /server/eula.txt
fi

if [[ ! -f "/run.sh" ]]; then
    cat << EOF > "/run.sh"
#!/bin/bash
cd /server
java -Xmx\${MEMORY_USAGE} -Xms\${MEMORY_USAGE} -jar spigot.jar nogui
EOF

    chmod +x /run.sh
fi

su-exec mcuser:mcuser /run.sh
