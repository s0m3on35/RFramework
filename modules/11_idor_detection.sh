#!/bin/bash
# IDOR Detection Module – Un1nv1t3dr34p3r
echo "[*] Starting IDOR Detection Module..."

INPUT_FILE="results/targets.txt"
OUTPUT_FILE="results/idor_findings.txt"
mkdir -p results

if [ ! -f "$INPUT_FILE" ]; then
    echo "[-] No target input file found at $INPUT_FILE"
    exit 1
fi

while read -r url; do
    if [[ "$url" =~ [0-9]+ ]]; then
        for i in $(seq 1 10); do
            test_url=$(echo "$url" | sed -E "s/[0-9]+/$i/")
            code=$(curl -s -o /dev/null -w "%{http_code}" "$test_url")
            echo "$test_url $code" >> "$OUTPUT_FILE"
        done
    fi
done < "$INPUT_FILE"

echo "[+] IDOR fuzzing results saved to $OUTPUT_FILE"
