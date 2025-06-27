#!/bin/bash

REPO_URL="https://github.com/your-org/Un1nv1t3dr34p3r"
MODULES_DIR="./"
TMP_DIR=$(mktemp -d)

echo " Checking for module updates from $REPO_URL..."

# Clone the remote repo (shallow for speed)
git clone --depth=1 "$REPO_URL" "$TMP_DIR" > /dev/null 2>&1

# Find new or updated modules
echo "🔍 Comparing modules..."
UPDATED=0
for module in $(find "$TMP_DIR" -type f -name "*.sh" -o -type d -name "modules_*"); do
  base=$(basename "$module")
  if [ -e "$MODULES_DIR/$base" ]; then
    diff -q "$module" "$MODULES_DIR/$base" > /dev/null
    if [ $? -ne 0 ]; then
      echo " Updating: $base"
      cp -r "$module" "$MODULES_DIR/"
      UPDATED=$((UPDATED + 1))
    fi
  else
    echo " Adding new module: $base"
    cp -r "$module" "$MODULES_DIR/"
    UPDATED=$((UPDATED + 1))
  fi
done

rm -rf "$TMP_DIR"

if [ "$UPDATED" -gt 0 ]; then
  echo " $UPDATED module(s) updated or added."
else
  echo " Everything is up to date."
fi
