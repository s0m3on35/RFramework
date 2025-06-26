#!/bin/bash
# IAM Hardening Recommender
# GPT-based suggestions for improving cloud IAM configurations

echo "[+] IAM Hardening Recommender"

read -p "Enter IAM policy or permissions file path (JSON): " IAM_FILE

if [[ ! -f "$IAM_FILE" ]]; then
    echo "[-] File not found!"
    exit 1
fi

echo "[*] Reading IAM configuration..."
cat "$IAM_FILE"

echo ""
echo "[+] Generating hardening suggestions..."
echo "(Placeholder) GPT Suggestions Based on IAM Analysis:" > iam_hardening_report.txt
echo "• Remove wildcard permissions ('*') from policies." >> iam_hardening_report.txt
echo "• Apply least privilege principle to all roles." >> iam_hardening_report.txt
echo "• Validate attached policies against known abuse patterns." >> iam_hardening_report.txt
echo "• Restrict access to sensitive actions like iam:PassRole." >> iam_hardening_report.txt

cat iam_hardening_report.txt

