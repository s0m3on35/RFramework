
#!/bin/bash
# wayback_hunter.sh - Historical URL Extractor

domain=$1
output="wayback_output.txt"
echo "[*] Extracting Wayback Machine URLs for $domain..."
curl -s "http://web.archive.org/cdx/search/cdx?url=*.$domain/*&output=text&fl=original&collapse=urlkey" | sort -u > $output

echo "[*] Extracting Common Crawl URLs for $domain..."
common_output="commoncrawl_output.txt"
for index in $(curl -s https://index.commoncrawl.org/collinfo.json | jq -r '.[].cdx-api'); do
  curl -s "$index?url=*.$domain/*&output=json" | jq -r .url >> $common_output
done

echo "[*] Filtering interesting URLs..."
cat $output $common_output | grep -Ei "\.js$|\.php$|\.bak$|admin|backup|\.git" | sort -u > wayback_filtered.txt

echo "[+] Done. Results saved in wayback_filtered.txt"
