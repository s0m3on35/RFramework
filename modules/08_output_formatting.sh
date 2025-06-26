#!/bin/bash

set -e
echo "[*] Step 8: Output Formatting & Report Generation"

TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
WORKDIR="results/step8_$TIMESTAMP"
mkdir -p "$WORKDIR"

echo "[*] Aggregating all results..."

# Merge all JSONs
find results/ -name "*.json" -exec cat {} \; > "$WORKDIR/all_findings_raw.json"

# Pretty-print JSON
jq '.' "$WORKDIR/all_findings_raw.json" > "$WORKDIR/all_findings_pretty.json" 2>/dev/null || cp "$WORKDIR/all_findings_raw.json" "$WORKDIR/all_findings_pretty.json"

# Extract CVEs, URLs, fingerprints
grep -Eoi 'http[s]?://[^"]+' "$WORKDIR/all_findings_pretty.json" | sort -u > "$WORKDIR/all_urls.txt"
grep -Eoi 'CVE-[0-9]{4}-[0-9]+' "$WORKDIR/all_findings_pretty.json" | sort -u > "$WORKDIR/all_cves.txt"

# Generate HTML and Markdown reports
echo "[*] Generating markdown report..."
echo "# Un1nv1t3dr34p3r Recon Report" > "$WORKDIR/report.md"
echo "Generated: $TIMESTAMP" >> "$WORKDIR/report.md"
echo "" >> "$WORKDIR/report.md"
echo "## CVEs Found" >> "$WORKDIR/report.md"
cat "$WORKDIR/all_cves.txt" >> "$WORKDIR/report.md"
echo "" >> "$WORKDIR/report.md"
echo "## URLs" >> "$WORKDIR/report.md"
cat "$WORKDIR/all_urls.txt" >> "$WORKDIR/report.md"

echo "[*] Converting to HTML..."
pandoc "$WORKDIR/report.md" -o "$WORKDIR/report.html" || echo "[!] pandoc not available, skipping HTML export."

echo "[✓] Step 8 completed. Reports saved in $WORKDIR"
