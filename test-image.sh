#!/usr/bin/env bash

# Spin up a new container
echo "🚀 Spinning up a test container"
docker-compose up -d

# Wait some time
echo "😴 sleeping 10 minutes"
sleep 10m

# Test for the string "Please restart the server" is in the server log
# If it is, then the server started successfully
# If it is not, then the server failed to start
echo "🧪 Testing for success"
if docker-compose logs | grep -q "Please restart the server"; then
  echo "✅ Server started successfully"
else
  echo "❌ Server failed to start"
  docker-compose logs
  docker-compose kill && docker-compose down --volumes
  exit 1
fi

# Cleanup and exit with 0
docker-compose kill && docker-compose down --volumes
echo "✅ Done, everything looks good"
exit 0
