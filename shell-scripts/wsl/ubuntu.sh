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
echo "cd /mnt/d/Code" >>~/.bashrc

##################################
####    FIX DOCKER STARTUP    ####
##################################
echo 'if [[ $(service docker status) != *"Docker is running"* ]]; then' >>~/.bashrc
echo 'service docker start' >>~/.bashrc
echo 'fi' >>~/.bashrc

##################################
####      ADVANCED CP MV      ####
##################################
# https://ostechnix.com/advanced-copy-add-progress-bar-to-cp-and-mv-commands-in-linux/

##################################
####         OH MY ZSH        ####
##################################
# https://www.the-digital-life.com/en/awesome-wsl-wsl2-terminal/
sudo apt-get install git wget zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
chsh -s $(grep /zsh$ /etc/shells | tail -1)

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions