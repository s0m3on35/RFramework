#!/bin/bash
echo "☁️ CSPM Risk Dashboard - Cloud Security Posture Review"

mkdir -p cspm_reports

echo "Scanning for exposed cloud assets, misconfigurations, and IAM policies..."
echo ""

# Placeholder: scan for bucket permissions, IAM issues, etc.
if [[ -f cloud_assets.txt ]]; then
  echo "Assets found:"
  cat cloud_assets.txt
  echo ""
  grep -i 'public\|open\|allow\|anyone' cloud_assets.txt > cspm_reports/exposed.txt
  echo "→ Exposed assets saved to: cspm_reports/exposed.txt"
else
  echo "No cloud_assets.txt file found. Please run cloud discovery tools first."
fi

echo "CSPM Scan complete."
