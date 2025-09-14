# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Paths
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/scripts"

# Alisases
alias update="aurcat up; flatpak update -y"
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias project-catppuccinifier-gui="cd ~/dev/personal/pc/catppuccinifier/src/catppuccinifier-gui/; nvim ."
alias project-catppuccinifier-cli="cd ~/dev/personal/pc/catppuccinifier/src/catppuccinifier-cli/; nvim ."
alias project-aurcat="cd ~/dev/whiskers-apps/pc/aurcat/; nvim ."
alias project-tigirs="cd ~/dev/whiskers-apps/pc/tigris/; nvim ."
alias project-tigris-core="cd ~/dev/whiskers-apps/pc/tigris-core/; nvim ."
alias project-tigris-launcher="cd ~/dev/whiskers-apps/pc/tigris/project/launcher; nvim ."
alias nvim-config="cd ~/.config/nvim; nvim ."

export PATH="$PATH:/home/lighttigerxiv/.local/bin"
export PATH=$PATH:/home/lighttigerxiv/.spicetify
