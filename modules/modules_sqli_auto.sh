#!/bin/bash
# SQL Injection Detection & Automation Module

echo "[*] Starting SQL Injection Scanner..."
read -p "Enter target URL or path to file: " target

if [[ -f "$target" ]]; then
    while read url; do
        echo "[*] Testing $url with sqlmap..."
        sqlmap -u "$url" --batch --risk=3 --level=5 --random-agent --output-dir=output/sqlmap_results
    done < "$target"
else
    echo "[*] Testing $target with sqlmap..."
    sqlmap -u "$target" --batch --risk=3 --level=5 --random-agent --output-dir=output/sqlmap_results
fi
