#!/bin/bash
# Source Map Parser
# Scans for exposed source maps and parses them for readable source code

echo "[+] Source Map Parser"

read -p "Enter URL or list file: " INPUT

mkdir -p smap_output

if [[ -f "$INPUT" ]]; then
    while IFS= read -r url; do
        echo "[*] Checking $url"
        if curl -s --head "$url" | grep -qi "200 OK"; then
            curl -s "$url" -o "smap_output/$(basename $url)"
        fi
    done < "$INPUT"
else
    echo "[*] Checking $INPUT"
    if curl -s --head "$INPUT" | grep -qi "200 OK"; then
        curl -s "$INPUT" -o "smap_output/$(basename $INPUT)"
    fi
fi

echo "[+] Download complete. Inspect .map files manually or use JSON formatter like jq."

