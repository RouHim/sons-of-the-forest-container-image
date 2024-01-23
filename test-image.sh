#!/usr/bin/env bash

# Spin up a new container
echo "🚀 Spinning up a test container"
docker run -d --name test-container rouhim/sons-of-the-forest

# Wait some time
echo "😴 sleeping 10 minutes"
sleep 10m

# Test for "[Self-Tests] Please restart the server"
echo "🧪 Testing for success"
docker logs test-container | grep -i '\[Self-Tests\] Please restart the server'
if [ "$?" -eq 0 ]; then
  echo "❌ Found errors in server log:"
  echo "======================"
  docker logs test-container
  echo "======================"
  docker kill test-container && docker rm test-container
  exit 1
fi

# Cleanup and exit with 0
docker kill test-container && docker rm test-container
echo "✅ Done, everything looks good"
exit 0
