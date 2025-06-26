#!/bin/bash
echo "🧠 GPT Recon Chat - Interactive CLI Assistant"
echo "Loading previous recon results (if available)..."
echo ""

# Simulate context awareness (demo mode)
if [ -f "results/nuclei_results.txt" ]; then
  echo "Found nuclei results. Summary:"
  grep -E "http|CVE" results/nuclei_results.txt | head -n 10
  echo "..."
fi

echo ""
echo "Type your recon question or 'exit':"
while true; do
  read -p "🤖 GPT> " question
  if [[ "$question" == "exit" ]]; then
    echo "Exiting GPT Recon Chat."
    break
  else
    echo "🔎 Thinking..."
    echo "→ (Pretend response from GPT about: '$question')"
    echo ""
  fi
done
