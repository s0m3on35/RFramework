#!/bin/bash
# CDN Bypass Detector
# Detecta proveedores de CDN y busca posibles IPs reales del origin

INPUT=$1
[ -z "$INPUT" ] && echo "Usage: $0 <target>" && exit 1

echo "[*] Analyzing headers..."
curl -s -I "$INPUT" | grep -iE "cf-ray|akamai|fastly|x-cache|via"

echo "[*] Attempting origin IP resolution via SecurityTrails and crt.sh..."
# Placeholder: integrate SecurityTrails or crt.sh lookup

echo "[*] DNS resolution (A records):"
dig +short "$INPUT"

echo "[*] Check for exposure..."
# Compare direct IP access response
# Placeholder for bypass test

echo "[+] Done. Check output for possible CDN bypass vectors."
