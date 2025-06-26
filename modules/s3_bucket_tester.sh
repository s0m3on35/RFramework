#!/bin/bash
echo "☁️ S3 Bucket Crawler & Access Tester"
mkdir -p s3_results

input_file="urls_collected.txt"
if [[ ! -f "$input_file" ]]; then
  echo "Missing '$input_file'"
  exit 1
fi

grep -oE '[a-zA-Z0-9.-]+\.s3\.amazonaws\.com' "$input_file" | sort -u > s3_results/buckets.txt

echo "[*] Probing for public access..."
> s3_results/buckets_accessible.txt
for b in $(cat s3_results/buckets.txt); do
  echo "Checking: http://$b" >> s3_results/buckets_accessible.txt
  curl -s -L "http://$b" | grep -Ei 'AccessDenied|ListBucketResult|<Key>' >> s3_results/buckets_accessible.txt
  echo "---" >> s3_results/buckets_accessible.txt
done

echo "[+] Done. Output in s3_results/"
