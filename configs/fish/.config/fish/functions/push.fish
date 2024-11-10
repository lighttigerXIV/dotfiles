function push --description "Do a commit and push"
    if test (count $argv) -eq 0
        echo "OH BURRO!! Tens de enviar uma mensagem"
    end
    
    git add -A
    git commit -m "$argv[1]"
    git push
end