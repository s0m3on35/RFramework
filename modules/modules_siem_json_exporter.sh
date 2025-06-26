#!/bin/bash
# SIEM JSON Exporter
# Converts scan results into structured JSON format for ingestion in SIEMs

echo "[+] SIEM JSON Exporter"

read -p "Enter path to results file (text): " INPUT_FILE
read -p "Enter output JSON file name: " OUTPUT_JSON

if [[ ! -f "$INPUT_FILE" ]]; then
    echo "[-] Input file not found!"
    exit 1
fi

echo "[" > "$OUTPUT_JSON"
while IFS= read -r line; do
    CLEANED=$(echo "$line" | sed 's/"/\"/g')
    echo "  { "finding": "$CLEANED" }," >> "$OUTPUT_JSON"
done < "$INPUT_FILE"

# Remove last comma
truncate -s-2 "$OUTPUT_JSON"
echo -e "
]" >> "$OUTPUT_JSON"

echo "[+] Exported to $OUTPUT_JSON"
