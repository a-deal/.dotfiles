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

1. Clone this repository:
   ```bash
   git clone [your-repo-url] ~/.dotfiles
   ```

2. Run the setup script:
   ```bash
   cd ~/.dotfiles
   source ./darwin  # Sets up environment variables
   ./install        # Creates symlinks with stow
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

3. **Hyper Terminal**: Install from https://hyper.is

4. **Fonts**: Install Inconsolata for Powerline font for proper terminal display

5. **tmux plugins**: Start tmux and press `Ctrl+a` then `I` to install plugins

6. **MCP Server**: 
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

## Updating

To update configurations:
```bash
cd ~/.dotfiles
git pull
source ./darwin
./install
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