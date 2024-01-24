#!/usr/bin/env bash

# Make sure that $SERVER_DIR is accessible for all
chmod -R 777 "$SERVER_DIR" 2> /dev/null
chown -R nobody:nogroup "$SERVER_DIR" 2> /dev/null

# Make sure that $SERVER_CONFIG_DIR is accessible for all
chmod -R 777 "$SERVER_CONFIG_DIR" 2> /dev/null
chown -R nobody:nogroup "$SERVER_CONFIG_DIR" 2> /dev/null

# Check if $SERVER_DIR is writeable
if [ ! -w "$SERVER_DIR" ]; then
    echo "❌ Error: $SERVER_DIR is not writeable!"
    exit 1
fi
echo "✅ Server data is writeable!"

# Check if $SERVER_DIR is readable
if [ ! -r "$SERVER_DIR" ]; then
    echo "❌ Error: $SERVER_DIR is not readable!"
    exit 1
fi
echo "✅ Server data is readable!"

# Check if $SERVER_CONFIG_DIR is writeable
if [ ! -w "$SERVER_CONFIG_DIR" ]; then
    echo "❌ Error: $SERVER_CONFIG_DIR is not writeable!"
    exit 1
fi
echo "✅ Server config is writeable!"

# Check if $SERVER_CONFIG_DIR is readable
if [ ! -r "$SERVER_CONFIG_DIR" ]; then
    echo "❌ Error: $SERVER_CONFIG_DIR is not readable!"
    exit 1
fi
echo "✅ Server config is readable!"

# Start virtual X server
echo "🖥️ Starting virtual display..."
export DISPLAY=":99"
rm -rf /tmp/.X* 2> /dev/null
Xvfb :99 -screen 0 1024x768x16 -nolisten tcp -nolisten unix &
wineboot -r

# Update server
echo "🔄 Updating server..."
$STEAMCMD +runscript "$USER_HOME"/steam-game.script

# Modify the $SERVER_CONFIG_DIR/dedicatedserver.cfg (json file) and set the value SkipNetworkAccessibilityTest to true
echo "🔧 Adjust server config..."
sed -i 's/"SkipNetworkAccessibilityTest": false/"SkipNetworkAccessibilityTest": true/g' "$SERVER_CONFIG_DIR"/dedicatedserver.cfg

# Start server
echo "🎮 Starting server..."
cd "$SERVER_DIR"
wine SonsOfTheForestDS.exe -userdatapath "$SERVER_CONFIG_DIR"