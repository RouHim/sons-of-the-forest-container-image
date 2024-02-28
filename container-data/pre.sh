#!/usr/bin/env sh


# Set skip network accessibility test to true
echo "🔧 Adjust server config..."
sed -i 's/"SkipNetworkAccessibilityTest": false/"SkipNetworkAccessibilityTest": true/g' "$SERVER_CONFIG_DIR"/dedicatedserver.cfg
