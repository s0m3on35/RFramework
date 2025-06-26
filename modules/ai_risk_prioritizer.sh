#!/bin/bash
echo "📊 AI Risk Prioritizer - Criticality Analysis Engine"

mkdir -p risk_scores

if [[ ! -f nuclei_results.txt ]]; then
  echo "No nuclei_results.txt found. Please run a vulnerability scan first."
  exit 1
fi

echo "Analyzing CVEs from nuclei_results.txt..."
grep -o 'CVE-[0-9]\{4\}-[0-9]\{4,7\}' nuclei_results.txt | sort -u > risk_scores/cves.txt

echo "Assigning severity levels using simulated CVSS..."
while read -r cve; do
  # Simulate a score and category
  score=$((RANDOM % 10 + 1))
  if (( score >= 9 )); then category="Critical"
  elif (( score >= 7 )); then category="High"
  elif (( score >= 4 )); then category="Medium"
  else category="Low"
  fi
  echo "$cve - CVSS $score.0 - $category" >> risk_scores/prioritized.txt
done < risk_scores/cves.txt

echo "Risk prioritization complete."
echo "→ Results saved in risk_scores/prioritized.txt"
