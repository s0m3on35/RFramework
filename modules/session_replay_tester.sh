#!/bin/bash
echo "🔁 Session Replay Tester - Reuse and Hijack Attempt"

mkdir -p session_replay_logs

if [[ ! -f session_cookies.txt ]]; then
  echo "Missing session_cookies.txt. Provide cookies or headers to test."
  exit 1
fi

# Simulate session replay attempts
echo "Testing session reuse with stored cookies..."

while read -r cookie; do
  echo "Using Cookie: $cookie"
  curl -s -o /dev/null -w "Status: %{http_code}\n" -H "Cookie: $cookie" https://example.com > "session_replay_logs/$(echo $cookie | md5sum | cut -d' ' -f1).txt"
done < session_cookies.txt

echo "Replay attempts complete. Check session_replay_logs/ for details."
