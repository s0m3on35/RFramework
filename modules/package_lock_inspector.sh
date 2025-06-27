#!/bin/bash
echo "package-lock.json Deep Inspector"

mkdir -p pkglock_results

echo "[*] Searching for package-lock.json files..."
find . -name "package-lock.json" > pkglock_results/files.txt

if [[ ! -s pkglock_results/files.txt ]]; then
  echo "[-] No package-lock.json files found."
  exit 1
fi

echo "[+] Found:"
cat pkglock_results/files.txt

echo "[*] Extracting all dependencies and versions..."

while read -r f; do
  echo "File: $f" >> pkglock_results/dependencies.txt
  cat "$f" | grep -E '"version": *"[^"]+"' >> pkglock_results/dependencies.txt
  echo "---" >> pkglock_results/dependencies.txt
done < pkglock_results/files.txt

echo "[*] Checking for suspicious packages..."

grep -iE 'event-stream|flatmap-stream|install-script|postinstall' pkglock_results/dependencies.txt > pkglock_results/suspicious.txt

echo "[+] Analysis complete."
echo " Results saved in pkglock_results/"
