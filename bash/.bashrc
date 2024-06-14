#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias paru="paru --bottomup"
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias update="paru -Syyyu; flatpak update;"
alias update-spicetify="spicetify backup apply"
alias dev-tauri="nvm use node; WEBKIT_DISABLE_COMPOSITING_MODE=1 bun run tauri dev"
alias build-tauri="nvm use node; bun run tauri build"
alias fix-nautilus="sudo sed -i 's|inode/directory=.*|inode/directory=org.gnome.Nautilus.desktop;code.desktop;|g' /usr/share/applications/mimeinfo.cache"

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

export PATH=$PATH:/home/lighttigerxiv/.spicetify

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2024-06-05 13:18:43
export PATH="$PATH:/home/lighttigerxiv/.local/bin"
