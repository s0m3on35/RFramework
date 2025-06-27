#!/bin/bash
echo " Sensitive Param Auto-Fuzzer"
mkdir -p fuzzer_results

input_file="urls_collected.txt"
if [[ ! -f "$input_file" ]]; then
  echo "Missing '$input_file'"
  exit 1
fi

params=("admin=true" "debug=1" "test=true" "env=prod" "auth=0")
> fuzzer_results/sensitive_param_responses.txt

for url in $(cat "$input_file"); do
  for p in "${params[@]}"; do
    mod_url="${url}?${p}"
    echo "[*] Testing: $mod_url" >> fuzzer_results/sensitive_param_responses.txt
    curl -s -o /tmp/fzout.txt -w "%{http_code}" "$mod_url" >> fuzzer_results/sensitive_param_responses.txt
    echo "" >> fuzzer_results/sensitive_param_responses.txt
    grep -Ei "debug|internal|error|flag" /tmp/fzout.txt >> fuzzer_results/sensitive_param_responses.txt
    echo "---" >> fuzzer_results/sensitive_param_responses.txt
  done
done

echo "[+] Done. Output in fuzzer_results/"
