#
# Tmux
#

if [ -z "$TMUX" ] # When zsh is started attach to current tmux session or create a new one
then
    tmux attach -t TMUX || tmux new -s TMUX
fi

#
# Neovim
#

export EDITOR="nvim"
alias vim="nvim"

#
# Oh-my-zsh
#

export ZSH="$HOME/.oh-my-zsh"

export SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true # Show prefix before first line in prompt
export SPACESHIP_BATTERY_SHOW=false
 
ZSH_THEME="spaceship" # Set theme


plugins=(
  git # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
  history-substring-search # ZSH port of Fish history search. Begin typing command, use up arrow to select previous use
  zsh-autosuggestions # Suggests commands based on your history
  zsh-completions # More completions
  zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
  colored-man-pages # Self-explanatory
  autojump
  )
autoload -U compinit && compinit # reload completions for zsh-completions

source $ZSH/oh-my-zsh.sh # required

# Colorize autosuggest
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

#
# Spaceship-prompt
#

# Spaceship-prompt customization
SPACESHIP_PROMPT_ORDER=(
dir             # Current directory section
user            # Username section
host            # Hostname section
git             # Git section (git_branch + git_status)
time          # Time stampts section
# hg            # Mercurial section (hg_branch  + hg_status)
# package       # Package version
# node          # Node.js section
# ruby          # Ruby section
# elixir        # Elixir section
# xcode         # Xcode section
# swift         # Swift section
# golang        # Go section
# php           # PHP section
# rust          # Rust section
# haskell       # Haskell Stack section
# julia         # Julia section
# docker        # Docker section
# aws           # Amazon Web Services section
# venv          # virtualenv section
# conda         # conda virtualenv section
# pyenv         # Pyenv section
# dotnet        # .NET section
# ember         # Ember.js section
# kubecontext   # Kubectl context section
exec_time       # Execution time
line_sep        # Line break
battery         # Battery level and status
vi_mode         # Vi-mode indicator
jobs            # Background jobs indicator
# exit_code     # Exit code section
char            # Prompt character
)

SPACESHIP_DIR_PREFIX="%{$fg[blue]%}┌─[%b "
SPACESHIP_DIR_SUFFIX="%{$fg[blue]%} ] "
SPACESHIP_CHAR_SYMBOL="%{$fg[blue]%}└─▪%b "

#
# Other
#

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# enable local executables
export PATH="$PATH:$HOME/bin"
typeset -U path # dedup occurences of ~/bin


# load up aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
else
    print "404: ~/.aliases and ~/.dotfiles/.aliases not found."
fi

# load environment variables from .env
[ -f ~/.env ] && source ~/.env

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Keybindings
bindkey -s ^f "tmux_sessionizer\n"
bindkey -s ^s "cht.sh\n"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dealair/src/utils/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dealair/src/utils/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dealair/src/utils/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dealair/src/utils/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by Windsurf
export PATH="/Users/dealair/.codeium/windsurf/bin:$PATH"

#
# Workstation Management Utilities
# Available executables in /usr/local/bin
#

# App Management Tools
# app-review          - Review installed applications with sizes and recent changes
# app-cleanup         - Clean up application caches and temporary files  
# remove-protected-apps - Remove protected/stubborn applications with elevated privileges

# Quick aliases for common workstation tasks
alias apps="app-review"
alias clean-apps="app-cleanup"
alias remove-app="remove-protected-apps"


. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/src/scripts:$PATH"
