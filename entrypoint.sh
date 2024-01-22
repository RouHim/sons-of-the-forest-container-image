#!/usr/bin/env bash

# Own home folder
chown -R user:user /home/user

# Start virtual X server
Xvfb :0 -screen 0 1024x768x16 -ac &

# Update server
echo "Updating server..."
$STEAMCMD +login anonymous \
          +app_update 2465200 \
          validate \
          +quit

# Start server
echo "Starting server..."
cd "$GAME_DIR"
wine SonsOfTheForestDS.exe