#!/bin/bash

if [[ -z "$(id mcuser 2>/dev/null)" ]]; then
    addgroup -g "${PGID}" mcuser
    adduser -H -D -G mcuser -u "${PUID}" mcuser
fi

if [[ ! -d "/server" ]]; then
    mkdir -p /server
    chown -R mcuser:mcuser /server
fi

if [[ ! -f "/server/bungeecord.jar" ]]; then
    echo "Downloading BungeeCord ${VERSION}..."
    curl -L -o "/server/bungeecord.jar" "https://ci.md-5.net/job/BungeeCord/${VERSION}/artifact/bootstrap/target/BungeeCord.jar"
fi

if [[ ! -f "/run.sh" ]]; then
    cat << EOF > "/run.sh"
#!/bin/bash
cd /server
java -Xmx\${MEMORY_USAGE} -Xms\${MEMORY_USAGE} -jar bungeecord.jar
EOF

    chmod +x /run.sh
fi

su-exec mcuser:mcuser /run.sh
