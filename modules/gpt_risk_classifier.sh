#!/bin/bash
echo " GPT-Based Risk Classifier & Exploit Scorer"
mkdir -p risk_analysis
input_dir="scan_results"
output_file="risk_analysis/scoreboard.txt"

if [[ ! -d "$input_dir" ]]; then
  echo "Missing directory: $input_dir"
  exit 1
fi

> "$output_file"
for file in "$input_dir"/*; do
  echo "Analyzing $file..." >> "$output_file"
  if grep -q -Ei "rce|ssrf|idor|unauthorized|critical|p1" "$file"; then
    echo "RISK: HIGH ⚠️" >> "$output_file"
  elif grep -q -Ei "xss|misconfig|token|p2" "$file"; then
    echo "RISK: MEDIUM ⚠" >> "$output_file"
  else
    echo "RISK: LOW 🟢" >> "$output_file"
  fi
  echo "---" >> "$output_file"
done

echo "[+] Risk scores saved in $output_file"
