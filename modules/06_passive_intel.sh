#!/bin/bash

set -e
echo "[*] Step 6: Passive Intelligence and External Recon APIs"

WORKDIR="results/step6_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Input check
if [ ! -f "subdomains" ]; then
    echo "[✗] Missing subdomains file. Run Step 1 first." >&2
    exit 1
fi

# Passive Recon APIs – requires user-provided API keys (place in .env)
if [ ! -f ".env" ]; then
    echo "[✗] Missing .env file with API keys for Shodan, Censys, etc." >&2
    exit 1
fi

source .env

# SHODAN
if [ ! -z "$SHODAN_API_KEY" ]; then
    echo "[*] Querying Shodan..."
    while read -r domain; do
        curl -s "https://api.shodan.io/dns/domain/$domain?key=$SHODAN_API_KEY" > "$WORKDIR/shodan_$domain.json" || true
    done < subdomains
fi

# CENSYS
if [ ! -z "$CENSYS_API_ID" ] && [ ! -z "$CENSYS_API_SECRET" ]; then
    echo "[*] Querying Censys..."
    while read -r domain; do
        curl -s -u "$CENSYS_API_ID:$CENSYS_API_SECRET"              "https://search.censys.io/api/v2/hosts/search?q=$domain"              > "$WORKDIR/censys_$domain.json" || true
    done < subdomains
fi

# SecurityTrails
if [ ! -z "$SECURITYTRAILS_KEY" ]; then
    echo "[*] Querying SecurityTrails..."
    while read -r domain; do
        curl -s "https://api.securitytrails.com/v1/domain/$domain"              -H "apikey: $SECURITYTRAILS_KEY"              > "$WORKDIR/securitytrails_$domain.json" || true
    done < subdomains
fi

# DNSDumpster
if command -v dnsdumpster &> /dev/null; then
    echo "[*] Running dnsdumpster (if installed)..."
    dnsdumpster -l subdomains -o "$WORKDIR/dnsdumpster.txt" || true
fi

echo "[✓] Step 6 completed. Output saved in $WORKDIR"
