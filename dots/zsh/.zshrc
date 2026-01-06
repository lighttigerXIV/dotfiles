# ================================================================
# Antidote (Plugin Manager)
# ================================================================

# Set the root name of the plugins files (.txt and .zsh) Antidote will use.
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Generate a new static file whenever .zsh_plugins.txt is updated.
# This makes subsequent Zsh loads very fast.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    # Source Antidote's core script first, then bundle plugins.
    # The path here depends on your installation method.
    # If installed with git:
    ( source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh && antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh )
    # If installed with Homebrew (macOS example):
    # ( source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh && antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh )
fi

# Source your static plugins file. This is the main performance benefit.
source ${zsh_plugins}.zsh

# Source antidote
source ~/.antidote/antidote.zsh

# Enable Ctrl Arrow
bindkey '^[[1;5D' backward-word # For Ctrl+Left
bindkey '^[[1;5C' forward-word  # For Ctrl+Right

# Enable History
HISTFILE="$HOME/.zsh_history" # Location of the history file
HISTSIZE=1000000              # Maximum number of lines in history in a session
SAVEHIST=1000000              # Maximum number of lines saved to the history file

# History command configuration
setopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file
setopt INC_APPEND_HISTORY     # Add commands to HISTFILE in order of execution (immediately)
setopt SHARE_HISTORY          # Share history between all sessions (recommended for multiple terminals)

# ================================================================
# Aliases
# ================================================================

alias suvim="sudo nvim"
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias update="yay -Syyu; flatpak update"
alias sennheiser-info="bluetoothctl info 00:1B:66:EA:8F:98"
alias get-window-class="qdbus org.kde.KWin /KWin queryWindowInfo"

# ================================================================
# Programs
# ================================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/nvim/bin:$PATH"
export PATH="$HOME/.config/hypr/hyprland/scripts:$PATH"


# Enable Sudo Colors
export SUDO_PROMPT="$(tput setaf 3 bold)Password:$(tput sgr0) "

# Load Antidote
antidote load

# Enable Starship Prompt
eval "$(starship init zsh)"
