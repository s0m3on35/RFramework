#!/bin/bash
# AI Recon Chat CLI Assistant
# Interactive CLI chat interface for recon support using GPT via local API or notes

echo "[+] AI Recon CLI Assistant"
echo "Type 'exit' to quit."
echo "Launching interactive prompt..."

LOG_FILE="ai_recon_chat_log.txt"
touch $LOG_FILE

while true; do
    read -p "🧠 You> " USER_INPUT
    if [[ "$USER_INPUT" == "exit" ]]; then
        echo "[+] Session ended."
        break
    fi
    echo "🧠 You> $USER_INPUT" >> $LOG_FILE
    echo "🤖 GPT> (placeholder response - connect to GPT API or local LLM here)" | tee -a $LOG_FILE
done
