#!/usr/bin/env sh

set -e

# Check if config file exists
if [ ! -f "$SERVER_CONFIG_DIR"/dedicatedserver.cfg ]; then
    echo "ℹ️  Config file not found: $SERVER_CONFIG_DIR/dedicatedserver.cfg - skipping config adjustment"
    exit 0
fi

# Set skip network accessibility test to true
echo "🔧 Adjust server config..."

CONFIG_FILE="$SERVER_CONFIG_DIR/dedicatedserver.cfg"
TEMP_FILE="$CONFIG_FILE.tmp"

# First, try to repair common JSON syntax errors
echo "🔧 Repairing any JSON syntax errors..."
sed 's/,,*/,/g' "$CONFIG_FILE" | sed 's/,\s*\([}\]]\)/\1/g' > "$TEMP_FILE"
mv "$TEMP_FILE" "$CONFIG_FILE"

# Use jq to properly handle JSON
jq '.SkipNetworkAccessibilityTest = true' "$CONFIG_FILE" > "$TEMP_FILE"
mv "$TEMP_FILE" "$CONFIG_FILE"

echo "✅ Config updated successfully"
