#!/usr/bin/env bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Bootstrapping dotfiles setup...${NC}"

# Create necessary directories
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p ~/.local/bin
touch ~/.local/bin/env  # Create empty env file if needed
mkdir -p ~/.ssh/sockets  # For SSH connection multiplexing

# Install oh-my-zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing oh-my-zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    # Install additional oh-my-zsh plugins
    echo -e "${YELLOW}Installing oh-my-zsh plugins...${NC}"
    
    # zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    else
        echo -e "${GREEN}zsh-autosuggestions already installed${NC}"
    fi
    
    # zsh-completions
    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
        git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions"
    else
        echo -e "${GREEN}zsh-completions already installed${NC}"
    fi
    
    # zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    else
        echo -e "${GREEN}zsh-syntax-highlighting already installed${NC}"
    fi
    
    # Install spaceship theme
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" ]; then
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt" --depth=1
        ln -sf "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
    else
        echo -e "${GREEN}spaceship theme already installed${NC}"
    fi
else
    echo -e "${GREEN}oh-my-zsh already installed${NC}"
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}Homebrew already installed${NC}"
fi

# Install packages from Brewfile
if command -v brew &> /dev/null && [ -f "Brewfile" ]; then
    echo -e "${YELLOW}Installing packages from Brewfile...${NC}"
    brew bundle
else
    echo -e "${RED}Brewfile not found or brew not available${NC}"
fi

# SSH Key Setup
echo -e "${YELLOW}Setting up SSH...${NC}"

# Check if SSH keys exist
if [ ! -f "$HOME/.ssh/id_ed25519" ] && [ ! -f "$HOME/.ssh/id_rsa" ]; then
    echo -e "${YELLOW}No SSH keys found. Would you like to generate one? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Enter your email for the SSH key:${NC}"
        read -r email
        ssh-keygen -t ed25519 -C "$email"
        
        # Add to keychain
        echo -e "${YELLOW}Adding SSH key to keychain...${NC}"
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        
        echo -e "${GREEN}SSH key generated!${NC}"
        echo -e "${YELLOW}Your public key has been copied to clipboard.${NC}"
        pbcopy < ~/.ssh/id_ed25519.pub
        echo -e "${YELLOW}Add it to GitHub: https://github.com/settings/ssh/new${NC}"
    fi
else
    # Add existing keys to keychain
    echo -e "${YELLOW}Adding existing SSH keys to keychain...${NC}"
    if [ -f "$HOME/.ssh/id_ed25519" ]; then
        ssh-add --apple-use-keychain ~/.ssh/id_ed25519 2>/dev/null || true
    fi
    if [ -f "$HOME/.ssh/id_rsa" ]; then
        ssh-add --apple-use-keychain ~/.ssh/id_rsa 2>/dev/null || true
    fi
fi

echo -e "${GREEN}Bootstrap complete!${NC}"
echo -e "${YELLOW}Now run: ./install${NC}"