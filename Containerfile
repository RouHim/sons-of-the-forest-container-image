# Use latest Ubuntu as base image
FROM ubuntu:24.04

# Define environment variables
ENV USER_HOME "/home/ubuntu"
ENV STEAMCMD "$USER_HOME/steamcmd/steamcmd.sh"
ENV SERVER_DIR "/data"
ENV SERVER_CONFIG_DIR "/config"

# Use default non root user ubuntu (1000)
WORKDIR $USER_HOME

# Install steamcmd and its dependencies
RUN apt update && \
    apt install -y wget ca-certificates lib32gcc-s1 && \
    mkdir -p $USER_HOME/steamcmd && \
    wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - -C $USER_HOME/steamcmd && \
    chown -R ubuntu:ubuntu $USER_HOME/steamcmd

# Install wine and its dependencies and do a full system upgrade to get the latest and greatest packages
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y --no-install-recommends wine wine32 wine64 winbind xvfb && \
    apt upgrade -y && apt dist-upgrade -y

# Cleanup, remove wget
RUN apt remove -y wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists

# Create game server and config directory
RUN mkdir -p $SERVER_DIR $SERVER_CONFIG_DIR
VOLUME $SERVER_DIR
VOLUME $SERVER_CONFIG_DIR

# Copy steam-game.script to container
COPY steam-game.script $USER_HOME/steam-game.script

# Change user to non-root user
RUN chown -R ubuntu:ubuntu $USER_HOME && \
    chown -R nobody:nogroup $SERVER_DIR $SERVER_CONFIG_DIR && \
    chmod 777 -R $SERVER_DIR $SERVER_CONFIG_DIR
USER ubuntu

# Game quvery port
EXPOSE 8766/udp
# Query port
EXPOSE 27016/udp
# Blobsync port
EXPOSE 9700/udp

# Define entrypoint
COPY --chown=ubuntu:ubuntu --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]