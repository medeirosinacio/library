#!/usr/bin/env bash
# https://www.the-digital-life.com/en/awesome-wsl-wsl2-terminal/

curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/functions/init_unixstartup.sh >/tmp/init_unixstartup.sh && chmod 755 /tmp/init_unixstartup.sh
INIT="/tmp/init_unixstartup.sh"
source "$INIT"

sudo apt-get install git wget zsh fzf -y

# folder .oh-my-shell not exist, install ZSH
if [ -z "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  chsh -s $(grep /zsh$ /etc/shells | tail -1)
fi

# file config ~/.zshrc not exist, create
FILE=~/.zshrc
if [ ! -f "$FILE" ]; then
  touch "$FILE"
fi

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting >/dev/null 2>&1
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions >/dev/null 2>&1
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null 2>&1

PARAMS=(
  'export LANG="en_US.UTF-8"'
  "export ZSH=\"/home/$USER/.oh-my-zsh\""
  'ZSH_THEME="robbyrussell"'
  'COMPLETION_WAITING_DOTS="true"'
  'plugins=(git common-aliases git-extras screen sudo history zsh-completions zsh-syntax-highlighting zsh-autosuggestions docker docker-compose colorize command-not-found zsh-interactive-cd)'
  'autoload -U compinit && compinit'
  'source $ZSH/oh-my-zsh.sh'
  'local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"'
  "PROMPT='\${ret_status} %{\$fg[cyan]%}%c%{\$reset_color%} \$(git_prompt_info)'"
  'RPROMPT="%D{%f/%m/%y} %T"'
  'if [ -f ~/.bash_aliases ]; then  . ~/.bash_aliases; fi'
  'if [ -f /etc/init.d/startup.sh ]; then  /etc/init.d/startup.sh; fi'
)

for param in "${PARAMS[@]}"; do
  if ! cat "$FILE" | grep -xqFe "$param"; then
    echo "$param" >>"$FILE"
  fi
done
