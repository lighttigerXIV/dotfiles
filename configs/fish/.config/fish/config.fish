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
set PATH "$HOME/.spicetify" $PATH

# Alias
alias update="yay; flatpak update -y"
alias download-vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'

# ============ Development Alias ================= #

alias dev-web='nvm use latest; yarn run dev; xdg-open http://localhost:5173/'
alias build-web="yarn run build"

alias dev-tauri="nvm use latest; WEBKIT_DISABLE_COMPOSITING_MODE=1 yarn run tauri dev"
alias build-tauri="nvm use latest; yarn run tauri build"

alias dev-rust="cargo run"
alias build-rust="cargo build --release"

alias pull="git pull"