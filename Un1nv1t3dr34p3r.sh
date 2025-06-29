#!/bin/bash

# Color codes
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
RESET="\e[0m"

# Setup
timestamp=$(date +%Y-%m-%d_%H%M%S)
logdir="results/$timestamp"
mkdir -p "$logdir"

# Function to run a module
run_step() {
    step="$1"
    echo -e "${YELLOW}[*] Running: $step${RESET}"
    bash "./modules/$step" > "$logdir/${step}.log" 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Completed: $step${RESET}"
    else
        echo -e "${RED}[✗] Failed: $step${RESET}"
    fi
}

# View logs
view_logs() {
    echo -e "${BLUE}Available log runs:${RESET}"
    find results -type d -mindepth 1 | sort
    echo -n "Enter timestamp folder to view logs: "
    read folder
    if [ -d "results/$folder" ]; then
        echo -e "${YELLOW}Logs in results/$folder:${RESET}"
        ls "results/$folder"
    else
        echo -e "${RED}Folder not found.${RESET}"
    fi
}

# Show help
show_help() {
    echo -e "${BLUE}Usage:${RESET}"
    echo "  This tool automates running reconnaissance modules."
    echo ""
    echo "  Modules are loaded from ./modules/"
    echo "  Output is saved in ./results/<timestamp>/"
}

# Main menu
show_menu() {
    echo -e "${YELLOW}==== R34P3R – The Un1nv1t3d Recon Engine ====${RESET}"
    echo "1) Run All Modules"
    echo "2) Run Individual Module"
    echo "3) View Logs"
    echo "4) Help"
    echo "5) Exit"
    echo -n "> "
    read choice

    case "$choice" in
        1)
            echo -e "${YELLOW}Running all modules...${RESET}"
            for script in modules/*.sh; do
                run_step "$(basename "$script")"
            done
            ;;
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
        3)
            view_logs
            ;;
        4)
            show_help
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option.${RESET}"
            ;;
    esac

    echo ""
    read -p "Press Enter to return to the menu..." dummy
    clear
    show_menu
}

show_menu

