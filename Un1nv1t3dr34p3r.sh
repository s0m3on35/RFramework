#!/bin/bash

# Colors
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
RESET="\e[0m"

# Banner
echo -e "${RED}"
echo "██████╗ ██████╗  █████╗ ██████╗ ██████╗  "
echo "██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗ "
echo "██████╔╝██████╔╝███████║██████╔╝██████╔╝ "
echo "██╔═══╝ ██╔═══╝ ██╔══██║██╔═══╝ ██╔═══╝  "
echo "██║     ██║     ██║  ██║██║     ██║      "
echo "╚═╝     ╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝      "
echo "         R34P3R – The Un1nv1t3d Recon Engine"
echo -e "${RESET}"

# Create results directory
timestamp=$(date +%Y-%m-%d_%H%M%S)
mkdir -p results/$timestamp

run_step() {
    step="$1"
    echo -e "${YELLOW}[i] Running: $step${RESET}"
    bash "./$step" > results/$timestamp/${step}.log 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Completed $step. Log saved to results/$timestamp/${step}.log${RESET}"
    else
        echo -e "${RED}[✗] Error during $step. Check results/$timestamp/${step}.log${RESET}"
    fi
}

show_menu() {
    echo -e "${YELLOW}Choose an option:${RESET}"
    echo "1) Run Full Framework"
    echo "2) Run Individual Step"
    echo "3) View Log Directory"
    echo "4) Help / Info"
    echo "5) Exit"
    echo -n "> "
    read choice
    case $choice in
        1)
            for script in 01_*.sh 02_*.sh 03_*.sh 04_*.sh 05_*.sh 06_*.sh 07_*.sh 08_*.sh 09_*.sh 10_*.sh; do
                run_step $script
            done
            ;;
        2)
            echo -e "${YELLOW}Available steps:${RESET}"
            select script in 01_* 02_* 03_* 04_* 05_* 06_* 07_* 08_* 09_* 10_* "Back"; do
                [[ $script == "Back" ]] && break
                run_step "$script"
                break
            done
            ;;
        3)
            echo "Saved logs:"
            ls -1 results/
            ;;
        4)
            echo -e "${GREEN}Un1nv1t3dr34p3r – Modular Recon & Exploitation Framework${RESET}"
            echo "Runs 10 modular steps for subdomain, fuzzing, AI vuln scan, secrets detection, PoC mapping, and reporting."
            ;;
        5)
            echo "Bye!"
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

while true; do
    show_menu
done


elif [ "$choice" == "18" ]; then
  echo "🚀 Running XSS Detection & Automation..."
  python3 modules/xss_detect.py
