#!/usr/bin/env bash

# Spin up a new container
echo "🚀 Spinning up a test container"
docker compose up -d

# Loop until the string is found
echo "🔍 Checking for the desired string in the logs..."
while true; do
  # Check if the desired string is in the logs
  if docker compose logs | grep -q "Please restart the server"; then
    echo "✅ Dedicated server started successfully"
    break
  fi

  # Print the 5 lines tail of the logs
  echo "📃 Desired string not found in the logs, printing the last 5 lines of the logs:"
  echo "========================================"
  docker compose logs --tail 5
  echo "========================================"

  # Wait for 5 seconds before checking again
  echo "⏳ Waiting for 5 seconds before checking again..."
  sleep 5
done

# Cleanup and exit with 0
docker compose kill && docker compose down --volumes
echo "✅ Done, everything looks good"
exit 0
