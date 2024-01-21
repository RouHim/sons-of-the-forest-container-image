# Use Ubuntu as base image
FROM ubuntu:24.04

# Use a non-root user to run the container for better security
RUN useradd -m user
WORKDIR /home/user

# Install wine
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y wget wine32 wine64 unzip winbind xvfb

# Download and install windows steamcmd
RUN wget --no-check-certificate https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip && \
    unzip steamcmd.zip -d steamcmd && \
    rm steamcmd.zip

# Cleanup
RUN apt remove -y unzip wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R user:user /home/user
USER user

# Create alias for wine steamcmd
ENV STEAMCMD "wine /home/user/steamcmd/steamcmd.exe"
ENV GAME_DIR "/home/user/steamcmd/steamapps/common/Sons Of The Forest Dedicated Server"
ENV CONFIG_DIR "/home/user/.wine/drive_c/users/user/AppData/LocalLow/Endnight/SonsOfTheForestDS"

# Create "sons of the forest" game server directory
RUN mkdir -p "$GAME_DIR"
VOLUME $GAME_DIR
VOLUME $CONFIG_DIR

COPY --chown=user:user --chmod=755 entrypoint.sh /home/user/entrypoint.sh
ENTRYPOINT ["/home/user/entrypoint.sh"]
