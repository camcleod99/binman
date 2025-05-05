#!/bin/bash
set -e

# Load environment variables
if [ -f /.env ]; then
  set -o allexport
  source /.env
  set +o allexport
else
  echo "Environment file /.env not found!"
  exit 1
fi

# Screenshot the page
chromium --headless --disable-gpu --no-sandbox --hide-scrollbars --virtual-time-budget=5000 \
  --screenshot=/tmp/fullpage.png \
  --window-size=1920,2000 \
  "$BINMAN_URL"

# Check that screenshot exists
if [ ! -f /tmp/fullpage.png ]; then
  echo "$(date +"%Y-%m-%d %H:%M") - Screenshot failed!"
  exit 1
fi

# Crop the image
convert /tmp/fullpage.png -crop 680x530+620+710 /var/www/html/bins.png

# Check that cropped image exists
if [ ! -f /var/www/html/bins.png ]; then
  echo "$(date +"%Y-%m-%d %H:%M") - Cropping failed!"
  exit 1
fi

# Write the current timestamp into last_update.txt (correct folder!)
date +"%A, %d %b %Y %H:%M" > /var/www/html/last_update.txt

# Write to Log that everything is GTG
echo "$(date +"%Y-%m-%d %H:%M") - Updated bins.png successfully"
