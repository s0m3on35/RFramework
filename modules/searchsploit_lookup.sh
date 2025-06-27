#!/bin/bash
echo " Searchsploit Integration - CVE Exploit Suggestion Engine"

mkdir -p searchsploit_results

if [[ ! -f nuclei_results.txt ]]; then
  echo "Missing nuclei_results.txt. Please run vulnerability scan first."
  exit 1
fi

grep -o 'CVE-[0-9]\{4\}-[0-9]\{4,7\}' nuclei_results.txt | sort -u > searchsploit_results/cves.txt

while read -r cve; do
  echo "Looking up $cve in Searchsploit..."
  searchsploit --color=always "$cve" > "searchsploit_results/$cve.txt"
done < searchsploit_results/cves.txt

echo "Searchsploit lookups saved in searchsploit_results/"
