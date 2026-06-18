#!/bin/bash

# =============================================
#   PROXMOX INSTALLER v2.0
#   Created by ImGunpoint
#   All Rights Reserved | ImGunpoint © 2026
# =============================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Cool ASCII Banner with ImGunpoint branding
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║   ██████╗ ██████╗  ██████╗ ██╗  ██╗███╗   ███╗ ██████╗ ██╗  ║
║   ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝████╗ ████║██╔═══██╗╚██╗ ║
║   ██████╔╝██████╔╝██║   ██║ ╚███╔╝ ██╔████╔██║██║   ██║ ╚██║║
║   ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗ ██║╚██╔╝██║██║   ██║ ██╔╝║
║   ██║     ██║  ██║╚██████╔╝██╔╝ ██╗██║ ╚═╝ ██║╚██████╔╝██╔╝ ║
║   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ║
║                                                              ║
║           ██████╗ ███╗   ██╗███████╗████████╗ █████╗ ██╗     ║
║          ██╔═══██╗████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ║
║          ██║   ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ║
║          ██║   ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ║
║          ╚██████╔╝██║ ╚████║███████║   ██║   ██║  ██║███████╗║
║           ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${PURPLE}${BOLD}                    ★ Powered by ImGunpoint ★${NC}"
    echo -e "${YELLOW}              One-file Proxmox Utility • 2026 Edition${NC}\n"
}

# Spinner animation
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while ps -p $pid > /dev/null 2>&1; do
        local temp=${spinstr#?}
        printf " [${CYAN}%c${NC}] " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Progress bar animation
progress_bar() {
    local duration=$1
    local message=$2
    echo -e "${YELLOW}${message}${NC}"
    echo -n "["
    for ((i=0; i<=20; i++)); do
        echo -n "${GREEN}█${NC}"
        sleep $(echo "scale=2; $duration/20" | bc)
    done
    echo -e "] ${GREEN}DONE!${NC}\n"
}

# Card style function
show_card() {
    local title=$1
    local desc=$2
    echo -e "${BLUE}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${BLUE}│${NC} ${BOLD}${title}${NC}"
    echo -e "${BLUE}│${NC} ${desc}"
    echo -e "${BLUE}└─────────────────────────────────────────────────────────────┘${NC}"
}

# Main menu
show_menu() {
    show_banner
    echo -e "${WHITE}${BOLD}                    PROXMOX INSTALLER MENU${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    show_card "1" "Make VM - Execute Daytona installer script"
    show_card "2" "Install everything - wget, curl, sudo, docker.io"
    show_card "3" "Install Proxmox - Full Docker Proxmox container"
    show_card "4" "Install Cloudflare - Cloudflared tunnel setup"
    show_card "5" "Run PROXMOX Again - Start existing container"
    show_card "0" "Exit - Close the installer"
    
    echo -e "\n${PURPLE}${BOLD}                    ImGunpoint • All rights reserved${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e -n "${GREEN}${BOLD}Select an option [0-5]: ${NC}"
}

# Option 1: Make VM
option1() {
    show_banner
    echo -e "${CYAN}${BOLD}>>> EXECUTING MAKE VM (Daytona Installer)${NC}\n"
    progress_bar 1.5 "Preparing Daytona environment..."
    
    echo -e "${YELLOW}Downloading and running Daytona installer...${NC}"
    curl -fsSL https://raw.githubusercontent.com/IamGunpoint/daytona/refs/heads/main/install.sh | bash &
    spinner $!
    
    echo -e "\n${GREEN}${BOLD}✓ Daytona VM installer completed!${NC}"
    echo -e "${PURPLE}ImGunpoint says: Your VM is ready!${NC}\n"
    read -p "Press Enter to return to menu..."
}

# Option 2: Install everything
option2() {
    show_banner
    echo -e "${CYAN}${BOLD}>>> INSTALLING ESSENTIAL PACKAGES${NC}\n"
    
    progress_bar 1 "Updating package lists..."
    apt update -y > /dev/null 2>&1 &
    spinner $!
    
    echo -e "${YELLOW}Installing wget, curl, sudo, docker.io...${NC}"
    apt install -y wget curl sudo docker.io > /dev/null 2>&1 &
    spinner $!
    
    progress_bar 2 "Finalizing installation..."
    
    echo -e "${GREEN}${BOLD}✓ All packages installed successfully!${NC}"
    echo -e "${PURPLE}ImGunpoint: Everything is ready for Proxmox!${NC}\n"
    read -p "Press Enter to return to menu..."
}

# Option 3: Install Proxmox
option3() {
    show_banner
    echo -e "${CYAN}${BOLD}>>> INSTALLING PROXMOX CONTAINER${NC}\n"
    
    echo -e "${YELLOW}Pulling and starting Proxmox Docker container...${NC}"
    
    docker run -d \
        --name proxmox-vm \
        --privileged \
        --device /dev/kvm \
        -p 6080:6080 \
        -p 2026:2222 \
        -p 8006:8006 \
        -e RAM=25600 \
        -e CPU=6 \
        -e DISK=256 \
        -e ROOT_PASS=root123 \
        -e VNC_PASS=admin123 \
        -v proxmox_data:/vm \
        hopingboyz/atyro-proxmox8 &
    
    spinner $!
    
    progress_bar 3 "Starting Proxmox services..."
    
    echo -e "${GREEN}${BOLD}✓ Proxmox container is now running!${NC}"
    echo -e "${WHITE}Access Proxmox at: ${CYAN}https://your-ip:8006${NC}"
    echo -e "${PURPLE}ImGunpoint: Proxmox deployed successfully!${NC}\n"
    read -p "Press Enter to return to menu..."
}

# Option 4: Install Cloudflare
option4() {
    show_banner
    echo -e "${CYAN}${BOLD}>>> INSTALLING CLOUDFLARE${NC}\n"
    
    progress_bar 1 "Downloading cloudflared..."
    
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -O /tmp/cloudflared.deb &
    spinner $!
    
    echo -e "${YELLOW}Installing cloudflared package...${NC}"
    dpkg -i /tmp/cloudflared.deb > /dev/null 2>&1 &
    spinner $!
    
    progress_bar 1.5 "Configuring Cloudflare..."
    
    echo -e "${GREEN}${BOLD}✓ Cloudflare (cloudflared) installed successfully!${NC}"
    echo -e "${WHITE}Run: ${CYAN}cloudflared tunnel login${NC} to authenticate"
    echo -e "${PURPLE}ImGunpoint: Secure tunnels ready!${NC}\n"
    read -p "Press Enter to return to menu..."
}

# Option 5: Run PROXMOX Again
option5() {
    show_banner
    echo -e "${CYAN}${BOLD}>>> STARTING PROXMOX CONTAINER${NC}\n"
    
    echo -e "${YELLOW}Starting proxmox-vm container...${NC}"
    docker start proxmox-vm > /dev/null 2>&1 &
    spinner $!
    
    progress_bar 1 "Waiting for container to boot..."
    
    echo -e "${GREEN}${BOLD}✓ Proxmox container started successfully!${NC}"
    echo -e "${PURPLE}ImGunpoint: Proxmox is back online!${NC}\n"
    read -p "Press Enter to return to menu..."
}

# Main loop
main() {
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1) option1 ;;
            2) option2 ;;
            3) option3 ;;
            4) option4 ;;
            5) option5 ;;
            0) 
                show_banner
                echo -e "${GREEN}${BOLD}Thanks for using PROXMOX INSTALLER by ImGunpoint!${NC}"
                echo -e "${PURPLE}See you next time!${NC}\n"
                exit 0 
                ;;
            *) 
                echo -e "${RED}Invalid option! Please choose 0-5.${NC}"
                sleep 1.5
                ;;
        esac
    done
}

# Run the tool
main
