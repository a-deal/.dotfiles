# .zprofile - Runs for login shells

# Set up Homebrew environment
if [[ -f /opt/homebrew/bin/brew ]]; then
    # Apple Silicon Mac
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    # Intel Mac
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Load SSH keys from keychain on startup
ssh-add --apple-load-keychain 2>/dev/null

# Add any other login shell configurations here