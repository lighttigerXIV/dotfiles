if status is-interactive
    # Commands to run in interactive sessions can go here
end

#Disable Greeting
set -U fish_greeting

#Run Starship
starship init fish | source

# Path
set -gx BUN_INSTALL "$HOME/.bun"
set PATH $BUN_INSTALL/bin $PATH
set PATH "$HOME/.local/bin" $PATH
set PATH "$HOME/.cargo/bin" $PATH
set PATH "$HOME/.config/hypr/scripts" $PATH

# Alias
alias update="yay; flatpak update -y"