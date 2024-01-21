#!/usr/bin/env bash

# Start virtual X server
export DISPLAY=:1.0
Xvfb :1 -screen 0 1024x768x24 &

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