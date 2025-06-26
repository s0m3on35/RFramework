#!/bin/bash

set -e
echo "[*] Step 1: Subdomain Enumeration + Spidering + JS Extraction"

WORKDIR="results/step1_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Subdomain enumeration
echo "[*] Running subfinder..."
docker run --rm -v $(pwd):/src projectdiscovery/subfinder:latest -dL /src/domains -silent -o /src/subdomains
cp subdomains "$WORKDIR/subdomains"

# DNS Resolution
echo "[*] Resolving with dnsx..."
docker run --rm -v $(pwd):/src projectdiscovery/dnsx:latest -l /src/subdomains -t 500 -retry 5 -silent -o /src/dnsx
cp dnsx "$WORKDIR/dnsx"

# Port scanning
echo "[*] Scanning with naabu..."
docker run --rm -v $(pwd):/src projectdiscovery/naabu:latest -l /src/dnsx -tp 1000 -ec -c 100 -rate 5000 -o /src/alive_ports
cp alive_ports "$WORKDIR/alive_ports"

# HTTP probing
echo "[*] Probing HTTP services with httpx..."
docker run --rm -v $(pwd):/src projectdiscovery/httpx:latest -l /src/alive_ports -t 100 -rl 500 -o /src/targets.txt
cp targets.txt "$WORKDIR/targets.txt"

# Spidering
echo "[*] Running katana for crawling..."
katana -l targets.txt -aff -j -o katana.jsonl
cp katana.jsonl "$WORKDIR/katana.jsonl"

# JavaScript link discovery (getJS)
echo "[*] Extracting JS links with getJS..."
docker run --rm -v $(pwd):/src secsi/getjs --input /src/targets.txt --complete --output /src/js_links
cp js_links "$WORKDIR/js_links"

# Optional: Katana JS enumeration
katana -u targets.txt -ps -em js,json >> js_links
cp js_links "$WORKDIR/js_links_extended"

echo "[✓] Step 1 completed. Output saved in $WORKDIR"
