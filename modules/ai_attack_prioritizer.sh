#!/bin/bash
echo "AI Attack Surface Prioritizer"

if [[ ! -f recon_findings_summary.txt ]]; then
  echo "Missing 'recon_findings_summary.txt'. Please generate it from previous modules."
  exit 1
fi

echo "Sending findings to GPT prompt..."

echo "
You are a cybersecurity expert. Given the following findings from recon, classify them into:
- High Risk
- Medium Risk
- Low Risk

Also suggest a recommended order of exploitation and what techniques could apply.

Findings:
---------------------------------------
$(cat recon_findings_summary.txt)
---------------------------------------
" > ai_prioritizer_prompt.txt

echo "[+] Prompt saved to: ai_prioritizer_prompt.txt"
echo "Use this prompt with ChatGPT or GPT-4 to evaluate risk and prioritize attack paths."
