#!/bin/bash
echo "🔐 JWT Analyzer & Brute - Checking for 'alg:none' and weak secrets"

mkdir -p jwt_results

if [[ ! -f jwt_tokens.txt ]]; then
  echo "Missing jwt_tokens.txt. Provide one JWT per line."
  exit 1
fi

if [[ ! -f jwt_wordlist.txt ]]; then
  echo "Missing jwt_wordlist.txt (for HMAC brute-force). Using default small list."
  echo -e "secret\nadmin\npassword\ntoken\n123456" > jwt_wordlist.txt
fi

while read -r token; do
  echo "Analyzing: $token"
  header=$(echo "$token" | cut -d '.' -f1 | base64 -d 2>/dev/null)
  alg=$(echo "$header" | jq -r '.alg')
  echo "  ➤ alg: $alg" >> jwt_results/analysis.txt

  if [[ "$alg" == "none" ]]; then
    echo "  ⚠️ Insecure: alg 'none' detected" >> jwt_results/analysis.txt
  else
    for word in $(cat jwt_wordlist.txt); do
      echo -n "$token" | jwt_tool -C -d -p "$word" &>/dev/null
      if [[ $? -eq 0 ]]; then
        echo "  ✅ Weak secret found: $word" >> jwt_results/analysis.txt
        break
      fi
    done
  fi
done < jwt_tokens.txt

echo "JWT analysis complete. Results in jwt_results/analysis.txt"
