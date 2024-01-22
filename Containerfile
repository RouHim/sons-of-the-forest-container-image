# Use Ubuntu as base image
FROM ubuntu:24.04

# Create a non-root user to run the container for better security
RUN useradd -m user
WORKDIR /home/user

# Install wine
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y --no-install-recommends wget unzip wine wine32 wine64 ca-certificates winbind xvfb

# Download and install windows steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip && \
    unzip steamcmd.zip -d steamcmd && \
    rm steamcmd.zip

# Cleanup
RUN apt remove -y unzip wget && \
    apt clean && \
    rm -rf /var/lib/apt/lists

# Define environment variables
ENV DISPLAY :0
ENV STEAMCMD "wine /home/user/steamcmd/steamcmd.exe"
ENV GAME_DIR "/home/user/steamcmd/steamapps/common/Sons Of The Forest Dedicated Server"
ENV CONFIG_DIR "/home/user/.wine/drive_c/users/user/AppData/LocalLow/Endnight/SonsOfTheForestDS"

# Create "sons of the forest" game server directory and config directory
RUN mkdir -p "$GAME_DIR" "$CONFIG_DIR"
VOLUME $GAME_DIR
VOLUME $CONFIG_DIR

# Change user to non-root user
RUN chown -R user:user /home/user
USER user

# Export ports
EXPOSE 8766/udp 27016/udp 9700/udp

# Define entrypoint
COPY --chown=user:user --chmod=755 entrypoint.sh /home/user/entrypoint.sh
ENTRYPOINT ["/home/user/entrypoint.sh"]
