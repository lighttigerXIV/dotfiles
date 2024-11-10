# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/home/lighttigerxiv/.spicetify:/home/lighttigerxiv/.cargo/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2024-06-05 13:18:43
export PATH="$PATH:/home/lighttigerxiv/.local/bin"

PS1='[\u@\h \W]\$ '

# Open Fish Shell
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi
