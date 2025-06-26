#!/bin/bash
echo "📡 Telemetry Leak Detection Module"
echo "Looking for telemetry endpoints, analytic beacons, and external data leaks..."

mkdir -p telemetry_logs

# Define common telemetry/analytics patterns
patterns="google-analytics|doubleclick.net|snowplow|hotjar|mixpanel|amplitude|datadoghq|segment.io|logrocket|sentry.io|appdynamics"

# Scan HTML and JS files (assumes you have saved content from recon/spidering)
find . -type f \( -iname "*.html" -o -iname "*.js" \) | while read -r file; do
  matches=$(grep -Ei "$patterns" "$file")
  if [[ ! -z "$matches" ]]; then
    echo "🔍 Potential telemetry in: $file"
    echo "$matches" > "telemetry_logs/$(basename $file).telemetry.txt"
  fi
done

echo "Scan complete. Results saved in telemetry_logs/"
