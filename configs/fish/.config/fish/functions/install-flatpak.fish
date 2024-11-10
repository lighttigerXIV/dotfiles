function install-flatpak --description "Install a flatpak"
    if test (count $argv) -eq 0
        echo "🙀 Missing flatpak id"
        exit 1
    end

    flatpak install flathub $argv[1]
end