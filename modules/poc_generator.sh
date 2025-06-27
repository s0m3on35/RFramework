#!/bin/bash
echo "[ PoC Generator] Starting module..."
echo "Reading from nuclei_results.txt (if exists)..."
if [[ -f nuclei_results.txt ]]; then
  grep 'CVE' nuclei_results.txt | while read -r line; do
    cve=$(echo "$line" | grep -o 'CVE-[0-9]*-[0-9]*')
    echo "Detected: $cve"
    template="templates/$cve.yaml"
    if [[ -f "$template" ]]; then
      echo " → Running PoC template: $template"
      nuclei -t "$template" -l urls.txt -o "poc_output/$cve.txt"
    else
      echo " → No template for $cve"
    fi
  done
else
  echo "No nuclei_results.txt found."
fi
