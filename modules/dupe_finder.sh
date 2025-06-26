#!/bin/bash
echo "🔎 AI-Based Duplicate Endpoint Finder"
mkdir -p dupe_results
input_file="urls_collected.txt"
if [[ ! -f "$input_file" ]]; then
  echo "Missing '$input_file'"
  exit 1
fi

awk -F'[?#]' '{print $1}' "$input_file" | sort | uniq -c | sort -nr > dupe_results/dupe_clusters.txt
echo "[+] Results saved in dupe_results/dupe_clusters.txt"
