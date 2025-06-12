if status is-interactive
    # Commands to run in interactive sessions can go here
end

#Disable Greeting
set -U fish_greeting

#Run Starship
starship init fish | source

# Path
set PATH "$HOME/.local/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH
set PATH "$HOME/.config/hypr/scripts" $PATH
set PATH "$HOME/.spicetify" $PATH
set PATH "$HOME/scripts/" $PATH

alias update="aurcat up; flatpak update -y"
alias download-vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'

alias restart="systemctl reboot"
alias logout="hyprctl dispatch exit"
