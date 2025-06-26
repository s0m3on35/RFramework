#!/bin/bash
echo "🧬 DOM-Based XSS Detector - JS Injection Analysis"

# Ensure input file exists
if [[ ! -f js_links.txt ]]; then
  echo "Missing js_links.txt. Please run JS enumeration first."
  exit 1
fi

mkdir -p domxss_results

echo "Scanning for DOM-based XSS sources in JavaScript files..."
while read -r jsurl; do
  echo "Analyzing: $jsurl"
  curl -s "$jsurl" | grep -Ei "(document\.location|location\.hash|innerHTML|eval|document\.write|setTimeout|setInterval)" > "domxss_results/$(echo $jsurl | md5sum | cut -d' ' -f1).txt"
done < js_links.txt

echo "DOM XSS detection completed. Results saved in domxss_results/"
