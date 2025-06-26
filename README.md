
# 🩸 Un1nv1t3dr34p3r – Bleeding Recon Engine

> "If you're going to be bad, do it well."

Un1nv1t3dr34p3r is a modular, AI-augmented offensive security framework for automated reconnaissance, vulnerability detection, and exploitation workflow orchestration.

---

## 🚀 Launch Instructions

### 📦 Requirements
- Linux or macOS with `bash`
- Dependencies: `nmap`, `httpx`, `nuclei`, `ffuf`, `jq`, etc. (see modules)

### ▶️ Start the Framework
```bash
chmod +x Un1nv1t3dr34p3r.sh
./Un1nv1t3dr34p3r.sh
```

---

## 🧩 Features

- Dynamic module loader (no hardcoded scripts)
- Organized modules by category:
  - Recon (subdomain, spidering, JS linkfinding)
  - Exploit (XSS, SSRF, SQLi, RCE)
  - Cloud (S3 Buckets, IAM, CSPM)
  - AI-Powered Modules (Prompt Generator, Risk Classifier, Recon Chat)
- Log saving and replay support
- CLI menu (numbered & category-based selection)

---

## 🖥️ CLI Preview

```
$ ./Un1nv1t3dr34p3r.sh

1) Run All Modules
2) Run Individual Module
3) View Logs
4) Help
5) Exit
```

---

## 📂 Folder Structure

```
RFramework/
├── Un1nv1t3dr34p3r.sh       # CLI Launcher
├── modules/                 # Modular scripts
├── results/                 # Output logs
├── assets/                  # Social preview banner
└── README.md
```

---

## 🌐 GitHub Pages

Documentation preview (if activated):  
➡️ [https://s0m3on35.github.io/RFramework](https://s0m3on35.github.io/RFramework)

---

## 🖼️ Social Preview

![R34P3R Banner](https://raw.githubusercontent.com/s0m3on35/RFramework/main/assets/banner.png)

---

## 💡 Credits

Crafted by 🧠 `s0m3on35` with an obsession for clean automation and full-stack exploitation.

---

## 📜 License

This project is released under the [MIT License](LICENSE).

---

🔒 **Stay sharp. Stay curious. Hack responsibly.**
