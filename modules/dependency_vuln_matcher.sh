#!/bin/bash
echo " Dependency Vulnerability Matcher"

mkdir -p dependency_results

echo "[*] Searching for dependency files..."

find . -name "package.json" > dependency_results/node_packages.txt
find . -name "requirements.txt" >> dependency_results/node_packages.txt
find . -name "pom.xml" >> dependency_results/node_packages.txt

if [[ ! -s dependency_results/node_packages.txt ]]; then
  echo "[-] No dependency files found."
  exit 1
fi

echo "[+] Found the following dependency files:"
cat dependency_results/node_packages.txt

echo "[*] Extracting library names and versions..."
cat dependency_results/node_packages.txt | while read depfile; do
  echo "File: $depfile" >> dependency_results/summary.txt
  grep -E '"[a-zA-Z0-9_\-]+": *"[0-9a-zA-Z\.\-\_]+"|[a-zA-Z0-9_\-]+==[0-9\.]+' "$depfile" >> dependency_results/summary.txt
  echo "---" >> dependency_results/summary.txt
done

echo "[*] Summary of detected libraries written to: dependency_results/summary.txt"
echo "📌 You can now use this list with OSV-Scanner, Snyk, or custom CVE mapping."
