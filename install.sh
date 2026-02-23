#!/bin/bash

# Bazzite Fluxer MusicBot Installer
# A straightforward installation Script/Guide for running Red-Fluxer Fork Bot for Music on Bazzite OS, as a Newbie myself i want to help others i struggled to do this but with the help of Ai it worked in the End.
# Repository: https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Bazzite Fluxer MusicBot Installer${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Main execution starts here
print_header

# Check if running on Bazzite/Fedora Atomic
if [ ! -f /etc/os-release ] || ! grep -q "bazzite\|fedora" /etc/os-release; then
    print_warning "This script is designed for Bazzite/Fedora Atomic systems."
    print_warning "Continue at your own risk."
    echo ""
fi

# Function to check and install packages
check_and_install() {
    local package=$1
    local check_command=$2
    
    print_info "Checking $package..."
    if eval "$check_command" &> /dev/null; then
        print_success "$package is already installed."
        return 0
    else
        print_warning "$package not found. Installing..."
        if rpm-ostree install "$package"; then
            print_success "$package installed successfully."
            return 1  # Reboot recommended
        else
            print_error "Failed to install $package."
            exit 1
        fi
    fi
}

# Check Python 3.11
check_and_install "python3.11" "command -v python3.11"
PYTHON_INSTALLED=$?

# Check Java 21
check_and_install "java-21-openjdk-headless" "command -v java"
JAVA_INSTALLED=$?

# Check pulseaudio-libs
check_and_install "pulseaudio-libs" "rpm -q pulseaudio-libs"
PULSE_INSTALLED=$?

# If any system package was installed, require reboot
if [ $PYTHON_INSTALLED -eq 1 ] || [ $JAVA_INSTALLED -eq 1 ] || [ $PULSE_INSTALLED -eq 1 ]; then
    print_warning "System packages were installed. A reboot is required."
    echo ""
    read -p "Would you like to reboot now? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Rebooting system..."
        systemctl reboot
        exit 0
    else
        print_warning "Please reboot manually later with: systemctl reboot"
        print_warning "After reboot, run this script again to continue."
        exit 0
    fi
fi

# Create virtual environment if it doesn't exist
print_info "Setting up Python virtual environment..."
if [ ! -d "$HOME/redenv" ]; then
    python3.11 -m venv ~/redenv
    print_success "Virtual environment created at ~/redenv"
else
    print_success "Virtual environment already exists."
fi

# Activate virtual environment
source ~/redenv/bin/activate

# Upgrade pip and install wheel
print_info "Upgrading pip and installing wheel..."
pip install --upgrade pip wheel --quiet
print_success "Pip upgraded."

# Install Red-DiscordBot (Fluxer fork)
print_info "Installing Red-DiscordBot (Fluxer fork)..."
if pip show Red-DiscordBot &> /dev/null; then
    print_info "Red-DiscordBot already installed. Checking for updates..."
    pip install --upgrade https://github.com/Red-Fluxer-Patches/Red-DiscordBot/archive/fluxer.tar.gz --quiet
    print_success "Red-DiscordBot updated."
else
    pip install https://github.com/Red-Fluxer-Patches/Red-DiscordBot/archive/fluxer.tar.gz --quiet
    print_success "Red-DiscordBot installed."
fi

# Setup systemd user service for auto-restart
print_info "Configuring auto-restart service..."

SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SERVICE_DIR/redbot.service"

mkdir -p "$SERVICE_DIR"

if [ ! -f "$SERVICE_FILE" ]; then
    cat > "$SERVICE_FILE" << EOF
[Unit]
Description=Red Discord Bot (Fluxer)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
Environment=RED_DPY_DEBUG=1
ExecStart=$HOME/redenv/bin/python -O -m redbot FluxMusicBot --no-prompt
WorkingDirectory=$HOME/.local/share/redbot
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
EOF
    print_success "Service file created."
else
    print_success "Service file already exists."
fi

# Reload systemd and enable service
systemctl --user daemon-reload
systemctl --user enable redbot.service &> /dev/null
systemctl --user start redbot.service &> /dev/null
print_success "Auto-restart service enabled and started."

# Final instructions
echo ""
print_success "══════════════════════════════════════════════════════════════"
print_success "  INSTALLATION COMPLETE!"
print_success "══════════════════════════════════════════════════════════════"
echo ""
print_info "Next steps:"
echo "  1. Run: redbot-setup"
echo "  2. Choose an instance name (e.g., fluxmusicbot)"
echo "  3. Run: redbot <your-instance-name>"
echo "  4. Follow the invite link to add the bot to your Fluxer server"
echo "  5. In Discord, type: !load audio"
echo "  6. Configure Spotify and YouTube API keys (see documentation)"
echo ""
print_info "Useful commands:"
echo "  • Check bot status: systemctl --user status redbot.service"
echo "  • View logs: journalctl --user -u redbot.service -f"
echo "  • Stop bot: systemctl --user stop redbot.service"
echo "  • Start bot: systemctl --user start redbot.service"
echo ""
print_success "Your bot is now running with auto-restart enabled!"
print_info "Documentation: https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide"
