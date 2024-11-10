function search --description "Search for packages"
    if test (count $argv) -eq 0
        echo "🙀 Missing package name"
        exit 1
    end

    yay $argv[1]
end