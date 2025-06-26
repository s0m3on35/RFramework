#!/bin/bash

RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
RESET="\e[0m"

echo -e "${RED}"

echo "    R34P3R – The Un1nv1t3d Recon Engine"
echo -e "${RESET}"

timestamp=$(date +%Y-%m-%d_%H%M%S)
mkdir -p results/$timestamp

run_step() {
    step="$1"
    echo -e "${YELLOW}[i] Running: $step${RESET}"
    bash "./modules/$step" > results/$timestamp/${step}.log 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Completed $step. Log saved to results/$timestamp/${step}.log${RESET}"
    else
        echo -e "${RED}[✗] Error during $step. Check results/$timestamp/${step}.log${RESET}"
    fi
}

show_menu() {
    echo -e "${YELLOW}Choose an option:${RESET}"
    echo "1) Run All Modules"
    echo "2) Run Individual Module"
    echo "3) View Logs"
    echo "4) Help"
    echo "5) Exit"
    echo -n "> "
    read choice

case $choice in

        2)
            echo -e "\nAvailable modules:"
            mapfile -t scripts < <(find modules -maxdepth 1 -name '*.sh' | sort)
            for i in "${!scripts[@]}"; do
                script_name=$(basename "${scripts[$i]}")
                printf "%2d) %s\n" "$((i+1))" "$script_name"
            done
            echo -n "Enter script number to run: "
            read module_number
            if [[ $module_number =~ ^[0-9]+$ ]] && (( module_number >= 1 && module_number <= ${#scripts[@]} )); then
                selected_script=$(basename "${scripts[$((module_number-1))]}")
                run_step "$selected_script"
            else
                echo -e "${RED}Invalid selection${RESET}"
            fi
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
esac

show_menu
}

show_menu
