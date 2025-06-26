#!/bin/bash
echo "[JS Analyzer] 🔍 Scanning JavaScript files for secrets and endpoints..."
mkdir -p results/js_analyzer
for js_url in $(cat results/js_links.txt 2>/dev/null); do
  echo "[+] Analyzing $js_url"
  curl -s "$js_url" | grep -E -i "apikey|token|secret|endpoint|url|pass|auth" >> results/js_analyzer/potential_findings.txt
done
echo "[JS Analyzer] ✅ Done. Results saved in results/js_analyzer/"
