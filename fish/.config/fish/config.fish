if status is-interactive
    # Commands to run in interactive sessions can go here
end

#Disable Fish Greeting
set -U fish_greeting

#Run Starship Prompt
starship init fish | source

# Path
set -gx BUN_INSTALL "$HOME/.bun"
set PATH $BUN_INSTALL/bin $PATH
source "$HOME/.cargo/env.fish"

# Alias
alias update="yay -Syyyu; flatpak update"
alias vencord-installer='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'


