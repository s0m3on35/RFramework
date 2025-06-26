#!/bin/bash

set -e
echo "[*] Step 10: Persistence & Remote Callback Setup"

WORKDIR="results/step10_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Webhook/Callback Configuration
WEBHOOK_URL="${WEBHOOK_URL:-}"
SCHEDULE="${SCHEDULE:-daily}"

# Save env info
echo "[i] Callback destination: $WEBHOOK_URL"
echo "[i] Schedule (cron-compatible): $SCHEDULE"

# Generate callback script
CALLBACK_SCRIPT="$WORKDIR/reaper_callback.sh"
cat <<EOF > "$CALLBACK_SCRIPT"
#!/bin/bash
LATEST_REPORT=\$(find results/ -name report.md | sort | tail -n 1)
if [ -f "\$LATEST_REPORT" ]; then
  curl -X POST -H "Content-Type: text/plain" -d @"\$LATEST_REPORT" "$WEBHOOK_URL"
else
  echo "[!] No report found to send." >&2
fi
EOF
chmod +x "$CALLBACK_SCRIPT"

# Generate crontab suggestion
CRONJOB="0 6 * * * bash $(pwd)/$CALLBACK_SCRIPT"
echo "$CRONJOB" > "$WORKDIR/cron_suggestion.txt"

echo "[✓] Callback script created: $CALLBACK_SCRIPT"
echo "[✓] Suggested cronjob saved: $WORKDIR/cron_suggestion.txt"

# Optional stealth callback with curl+dnslog
echo "[*] Example stealth callback:"
echo 'curl http://<uniqueID>.oastify.com'

echo "[✓] Step 10 completed. You can now configure this to auto-send reports to a webhook or alerting system."
