#!/bin/bash

echo "Installing dependencies for Un1nv1t3dr34p3r..."

# Basic packages
sudo apt update
sudo apt install -y curl wget git jq nmap masscan python3-pip unzip build-essential

# Recon tools
sudo apt install -y ffuf sqlmap

# Nuclei
if ! command -v nuclei &> /dev/null; then
    echo "[*] Installing nuclei..."
    curl -s https://api.github.com/repos/projectdiscovery/nuclei/releases/latest \
      | grep "browser_download_url.*nuclei.*linux_amd64.zip" \
      | cut -d '"' -f 4 \
      | wget -qi -
    unzip nuclei*.zip
    chmod +x nuclei
    sudo mv nuclei /usr/local/bin/
    rm nuclei*.zip
fi

# Dalfox
if ! command -v dalfox &> /dev/null; then
    echo "[*] Installing dalfox..."
    go install github.com/hahwul/dalfox/v2@latest
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# pup (HTML parser)
if ! command -v pup &> /dev/null; then
    echo "[*] Installing pup..."
    wget https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_0.4.0_linux_amd64.zip
    unzip pup_0.4.0_linux_amd64.zip
    chmod +x pup
    sudo mv pup /usr/local/bin/
    rm pup_0.4.0_linux_amd64.zip
fi

echo "✅ All core tools installed. You're ready to reap."
