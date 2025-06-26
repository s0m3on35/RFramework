#!/bin/bash
# Open Redirect & Redirect Chain Mapper
echo "[*] Starting Open Redirect & Chain Mapper..."
read -p "Enter target base URL (e.g., https://example.com/redirect?url=): " base
read -p "Enter redirection test (e.g., https://evil.com): " payload

echo "[*] Testing redirect..."
curl -s -I "${base}${payload}"

echo "[*] Following redirection chain..."
curl -Ls -o /dev/null -w %{url_effective} "${base}${payload}"
