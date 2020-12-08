#!/usr/bin/env bash
# chmod 755 ./ubuntu.sh

##################################
####       UPDATE DISTRO      ####
##################################
sudo apt update -y
sudo apt upgrade -y

##################################
####       INSTALL UTIL       ####
##################################
sudo apt install net-tools nmap tree -y

# Install docker and docker-compose
rm -rf /tmp/docker_wsl2_ubuntu.sh
curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install/docker_wsl2_ubuntu.sh >/tmp/docker_wsl2_ubuntu.sh
chmod 755 /tmp/docker_wsl2_ubuntu.sh
/tmp/docker_wsl2_ubuntu.sh

##################################
####   Configure Home Bash    ####
##################################
#echo "cd /mnt/d/Code" >>~/.bashrc

##################################
####    FIX DOCKER STARTUP    ####
##################################
echo 'if [[ $(service docker status) != *"Docker is running"* ]]; then' >>~/.bashrc
echo '  sudo service docker start' >>~/.bashrc
echo 'fi' >>~/.bashrc

##################################
####      ADVANCED CP MV      ####
##################################
# https://ostechnix.com/advanced-copy-add-progress-bar-to-cp-and-mv-commands-in-linux/

##################################
####         OH MY ZSH        ####
##################################
# https://www.the-digital-life.com/en/awesome-wsl-wsl2-terminal/
sudo apt-get install git wget zsh fzf -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(grep /zsh$ /etc/shells | tail -1)

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Now that we got the extras, let's start editing zshrc
echo """
export LANG="en_US.UTF-8"
export ZSH=\"/home/$USER/.oh-my-zsh\"
ZSH_THEME=\"robbyrussell\"
COMPLETION_WAITING_DOTS=\"true\"
plugins=(git common-aliases git-extras screen sudo history zsh-completions zsh-syntax-highlighting zsh-autosuggestions docker docker-compose colorize command-not-found zsh-interactive-cd)
autoload -U compinit && compinit
source \$ZSH/oh-my-zsh.sh
local ret_status=\"%(?:%{\$fg_bold[green]%}➜ :%{\$fg_bold[red]%}➜ )\"
PROMPT='\${ret_status} %{\$fg[cyan]%}%c%{\$reset_color%} \$(git_prompt_info)'
RPROMPT=\"%D{%f/%m/%y} %T\"

""" >~/.zshrc

echo 'if [[ $(service docker status) != *"Docker is running"* ]]; then' >>~/.zshrc
echo '  sudo service docker start' >>~/.zshrc
echo 'fi' >>~/.zshrc

echo 'alias dockerup="docker-compose up -d --force-recreate --build --remove-orphans"' >>~/.zshrc
echo 'alias dockerdown="docker-compose down "' >>~/.zshrc
echo 'alias dockerex="docker-compose exec -it "' >>~/.zshrc
