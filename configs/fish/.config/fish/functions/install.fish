function install --description "Install a package from official packages"
    if test (count $argv) -eq 0
        echo "🙀 Missing package name"
        exit 1
    end

    yay -S $argv[1]
end