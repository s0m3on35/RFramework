#!/bin/bash
echo "🧠 AI Prompt Generator for Recon Tools"
mkdir -p ai_prompts
read -p "Enter domain or target: " target

echo "[*] Generating prompts for: $target" > ai_prompts/generated_prompts.txt

echo "FFUF: Use wordlist 'raft-medium-directories.txt' on $target with -recursion" >> ai_prompts/generated_prompts.txt
echo "NUCLEI: Scan $target with templates: cves/, misconfiguration/, exposed-panels/" >> ai_prompts/generated_prompts.txt
echo "DALFOX: Run dalfox url '$target' --deep-dive" >> ai_prompts/generated_prompts.txt
echo "KATANA: Crawl all links and JS files from $target" >> ai_prompts/generated_prompts.txt

echo "[+] Prompts written to ai_prompts/generated_prompts.txt"
