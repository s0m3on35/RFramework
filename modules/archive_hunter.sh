#!/bin/bash
echo "📁 Archive & Backup File Hunter"
mkdir -p archive_hunter
input="urls_collected.txt"
if [[ ! -f "$input" ]]; then echo "Missing $input"; exit 1; fi

echo "[*] Searching for .zip, .tar.gz, .bak, .old, etc..." > archive_hunter/results.txt
grep -Ei '\.(zip|rar|tar\.gz|tar|7z|bak|old)(\?|$)' "$input" >> archive_hunter/results.txt
echo "[+] Output: archive_hunter/results.txt"
