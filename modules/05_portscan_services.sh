#!/bin/bash

set -e
echo "[*] Step 5: Port Scanning and Service Detection"

WORKDIR="results/step5_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Input validation
if [ ! -f "dnsx" ]; then
    echo "[✗] dnsx results not found. Run Step 1 first." >&2
    exit 1
fi

# Masscan for fast port discovery (optional)
echo "[*] Running masscan for TCP ports (top 1000)..."
masscan -p1-65535 --rate=10000 -iL dnsx -oX "$WORKDIR/masscan.xml" || true

# Nmap with service detection
echo "[*] Running Nmap on discovered hosts..."
nmap -iL dnsx -p- -T4 -sV -oA "$WORKDIR/nmap_full_scan" || true

# Optional: Run httpx again for updated services
echo "[*] Updating target info with httpx (detailed)..."
httpx -l dnsx -tech-detect -title -status-code -json -o "$WORKDIR/httpx_fingerprint.json" || true

echo "[✓] Step 5 completed. Output saved in $WORKDIR"
