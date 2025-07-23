# My Dotfiles

Personal configuration files for macOS development environment.

## What's Included

- **bin**: Personal scripts and utilities
- **gh**: GitHub CLI configuration
- **nvim**: Neovim configuration
- **tmux**: Terminal multiplexer with custom key bindings and plugins
- **zsh**: Shell configuration with aliases and custom settings
- **hyper**: Hyper terminal emulator with Nord theme
- **claude**: Claude AI assistant configuration with MCP server setup

## Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)

Install stow:
```bash
brew install stow
```

## Installation

### Quick Install (if you already have Git and SSH keys)

```bash
# Clone the repository
git clone git@github.com:a-deal/.dotfiles.git ~/.dotfiles

# Run bootstrap (first time only)
cd ~/.dotfiles && ./scripts/bootstrap.sh

# Install dotfiles
./install && exec zsh
```

### Full Installation Steps

1. **Set up SSH keys for GitHub** (if not already done):
   ```bash
   # Generate SSH key
   ssh-keygen -t ed25519 -C "your.email@example.com"
   
   # Start SSH agent and add key
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   
   # Copy public key to clipboard
   pbcopy < ~/.ssh/id_ed25519.pub
   
   # Add to GitHub: Settings → SSH and GPG keys → New SSH key
   ```

2. **Clone this repository**:
   ```bash
   git clone git@github.com:a-deal/.dotfiles.git ~/.dotfiles
   ```

3. **Run the bootstrap script** (first time only):
   ```bash
   cd ~/.dotfiles
   ./scripts/bootstrap.sh
   ```
   This will:
   - Install Homebrew (if needed)
   - Install all packages from Brewfile (tmux, autojump, stow, etc.)
   - Install oh-my-zsh and required plugins
   - Install spaceship prompt theme
   - Create necessary directories (~/.local/bin)

4. **Install dotfiles**:
   ```bash
   ./install
   exec zsh  # Restart shell
   ```

5. **Install Fira Mono Nerd Font**:
   ```bash
   # Option 1: Using Homebrew
   brew install --cask font-fira-mono-nerd-font
   
   # Option 2: Manual download
   curl -L -o ~/Downloads/FiraMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip
   cd ~/Downloads && unzip FiraMono.zip -d FiraMono
   cp FiraMono/*.ttf ~/Library/Fonts/
   rm -rf FiraMono FiraMono.zip
   ```

## Manual Setup Required

After installation, you'll need to:

1. **GitHub CLI**: Copy and update the hosts.yml template:
   ```bash
   cp ~/.dotfiles/gh/.config/gh/hosts.yml.template ~/.dotfiles/gh/.config/gh/hosts.yml
   # Edit the file to add your GitHub username and personal access token
   ```

2. **Claude Desktop Config**: Copy and update the config template:
   ```bash
   cp ~/.dotfiles/claude/claude_desktop_config.json.template ~/.dotfiles/claude/claude_desktop_config.json
   # Edit the file to update the MCP server paths
   ```

3. **Hyper Terminal**: Should be installed via Brewfile, or manually from https://hyper.is

4. **tmux plugins**: Start tmux and press `Ctrl+a` then `I` to install plugins

5. **MCP Server**: 
   - Clone zen-mcp-server if using MCP features
   - Update paths in your local `claude_desktop_config.json` to match your MCP server location

## Configuration Details

### Hyper
- Located at `~/.hyper.js`
- Configured with Nord theme
- Uses Inconsolata for Powerline font

### tmux
- Config at `~/.tmux.conf`
- Custom prefix key: `Ctrl+a`
- Plugin manager (TPM) included

### Claude
- Instructions at `~/.claude/CLAUDE.md`
- Desktop config at `~/Library/Application Support/Claude/claude_desktop_config.json`
- Contains MCP server integration settings

### zsh
- Main config at `~/.zshrc`
- Aliases at `~/.aliases`
- Custom functions and environment variables

## Common Commands

### Update dotfiles
```bash
cd ~/.dotfiles && git pull && ./install
```

### Update packages
```bash
cd ~/.dotfiles && brew bundle
```

### Troubleshooting

If you get errors about missing commands or files:
```bash
# Re-run bootstrap to ensure everything is installed
cd ~/.dotfiles && ./scripts/bootstrap.sh

# Force re-stow all configurations
cd ~/.dotfiles && ./install

# Restart your shell
exec zsh
```

## Uninstalling

To remove symlinks:
```bash
cd ~/.dotfiles
./cleanenv
```

## Security Notes

- The `gh/.config/gh/hosts.yml` file contains your GitHub personal access token and is gitignored
- The `claude/claude_desktop_config.json` contains local paths and is gitignored
- Use the provided `.template` files to set up these configurations on new machines
- Never commit files containing secrets or personal access tokens

## Notes

- Both `hosts.yml` and `claude_desktop_config.json` are gitignored for security
- Use the template files to recreate them on new machines
- Some configurations may require additional software installation (see Manual Setup)