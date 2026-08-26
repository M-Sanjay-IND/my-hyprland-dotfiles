# ==============================================================================
# Oh My Zsh & Plugins Setup
# ==============================================================================
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_CUSTOM="$ZSH/custom"

# Install Oh-My-Zsh if it doesn't exist
if [ ! -d "$ZSH" ]; then
  echo "Installing Oh-My-Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH" >/dev/null 2>&1
fi

# Auto-fetch necessary plugins if they don't exist
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" >/dev/null 2>&1
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" >/dev/null 2>&1
fi

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# History Configuration
# ==============================================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# ==============================================================================
# Custom Functions
# ==============================================================================

# Automatically list directory contents upon changing directories
cd() {
  builtin cd "$@" && ls
}

# ==============================================================================
# Execute Fastfetch on Interactive Terminal Startup & Clear
# ==============================================================================
if [[ -o interactive ]] && command -v fastfetch &>/dev/null; then
  fastfetch
fi

# Sustain Fastfetch design after running 'clear' or 'cls'
clear() {
  command clear
  if command -v fastfetch &>/dev/null; then
    fastfetch
  fi
}
alias cls="clear"

# Redraw Fastfetch on Ctrl+L clear
function clear-screen-and-fetch() {
  command clear
  if command -v fastfetch &>/dev/null; then
    fastfetch
  fi
  zle reset-prompt
}
zle -N clear-screen-and-fetch
bindkey '^L' clear-screen-and-fetch

# Load User Aliases
source /home/sanjaym/.config/zsh/user_aliases.zsh
stty -ixon 2>/dev/null
