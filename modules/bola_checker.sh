#!/bin/bash
echo "🔓 BOLA Checker - Broken Object Level Authorization Detector"

mkdir -p bola_results

if [[ ! -f endpoints_with_ids.txt ]]; then
  echo "Missing endpoints_with_ids.txt. Provide endpoints like /api/user/1234"
  exit 1
fi

echo "Testing endpoints with ID manipulation..."

while read -r url; do
  base=$(echo "$url" | sed -E 's/[0-9]{1,}/ID/')
  echo "Testing variations for: $base"

  for id in {1..5}; do
    test_url=$(echo "$url" | sed -E "s/[0-9]{1,}/$id/")
    echo "GET $test_url" >> bola_results/attempts.txt
    curl -s -o /dev/null -w "[$id] %{http_code}\n" "$test_url" >> bola_results/response_codes.txt
  done
done < endpoints_with_ids.txt

echo "BOLA testing completed. Results in bola_results/"
