#!/bin/bash
echo " CMS Detector & Fingerprinter"

mkdir -p cms_results

if [[ ! -f cms_targets.txt ]]; then
  echo "Missing cms_targets.txt. Add targets (http/https URLs) to scan."
  exit 1
fi

for url in $(cat cms_targets.txt); do
  echo "[*] Scanning $url..."
  whatweb -a 3 --color=never "$url" > cms_results/$(echo $url | md5sum | cut -d' ' -f1).txt
done

echo "CMS detection complete. Results saved in cms_results/"
