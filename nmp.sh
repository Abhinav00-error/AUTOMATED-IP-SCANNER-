#!/bin/bash

# Display Banner
display_banner() {
    echo -e "\033[1;31m"  # Set text color to red
    echo "======================================"
    echo "          TOOL CREATED BY ABHINAV VK"
    echo "======================================"
    echo "           _________  "
    echo "          /         \ "
    echo "         /           \ "
    echo "        |   X     X   | "
    echo "        |     ---     | "
    echo "         \    ---    / "
    echo "          \_________/ "
    echo "        ⚠️  DANGER: USE THIS TOOL RESPONSIBLY. ⚠️"
    echo "    ALWAYS OBTAIN PERMISSION BEFORE YOU SCAN."
    echo "======================================"
    echo -e "\033[0m"  # Reset text color to default
}

# Show Menu
show_menu() {
    echo "========================="
    echo "     SELECT A SCAN OPTION"
    echo "========================="
    echo "1. Aggressive Scan (-A)"
    echo "   Performs an in-depth scan with version detection, OS detection, and traceroute."
    echo ""
    echo "2. Full Port Scan (-p-)"
    echo "   Scans all 65,535 TCP ports on the target."
    echo ""
    echo "3. Service Version Detection (-sV)"
    echo "   Detects versions of services running on open ports."
    echo ""
    echo "4. OS Detection (-O)"
    echo "   Attempts to determine the operating system of the target."
    echo ""
    echo "5. Vulnerability Scan (--script vuln)"
    echo "   Checks for common vulnerabilities using Nmap scripts."
    echo ""
    echo "6. Firewall Evasion Techniques (-f)"
    echo "   Uses fragmentation to evade firewalls."
    echo ""
    echo "7. UDP Scan (-sU)"
    echo "   Scans for open UDP ports on the target."
    echo ""
    echo "8. Comprehensive Scan"
    echo "   Combines aggressive scanning, vulnerability checks, and full port scans."
    echo ""
    echo "9. DNS Enumeration (--script dns-brute)"
    echo "   Enumerates subdomains using DNS brute force."
    echo ""
    echo "10. Exit"
}

# Confirmation Prompt
confirm_scan() {
    while true; do
        read -p "Think before you scan. Do you want to proceed? (y/n): " confirm
        case $confirm in
            [Yy]*) return 0 ;;
            [Nn]*) echo "Scan canceled."; return 1 ;;
            *) echo "Please answer y or n." ;;
        esac
    done
}

# Execute Selected Scan
execute_scan() {
    local option=$1
    local ip=$2

    case $option in
        1)
            command="nmap -A $ip"
            ;;
        2)
            command="nmap -p- $ip"
            ;;
        3)
            command="nmap -sV $ip"
            ;;
        4)
            command="nmap -O $ip"
            ;;
        5)
            command="nmap --script vuln $ip"
            ;;
        6)
            command="nmap -f $ip"
            ;;
        7)
            command="nmap -sU $ip"
            ;;
        8)
            command="nmap -A -p- --script vuln $ip"
            ;;
        9)
            command="nmap --script dns-brute $ip"
            ;;
        *)
            echo "Invalid option. Please try again."
            return
            ;;
    esac

    echo "Executing: $command"
    eval $command
}

# Main Function
main() {
    display_banner

    while true; do
        show_menu
        read -p "Enter your choice: " choice

        if [[ $choice -eq 10 ]]; then
            echo "Exiting. Goodbye!"
            break
        fi

        read -p "Enter the target IP address: " ip

        if confirm_scan; then
            execute_scan $choice $ip
        fi
    done
}

# Run Main Function
main

