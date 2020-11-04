#!/usr/bin/env bash
# chmod 755 ./ubuntu.sh

##################################
####       UPDATE DISTRO      ####
##################################
apt update -y
apt upgrade -y

##################################
####       INSTALL UTIL       ####
##################################
apt install net-tools nmap tree -y

# Install docker and docker-compose
rm -rf /tmp/docker_wsl2_ubuntu.sh
curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install/docker_wsl2_ubuntu.sh >/tmp/docker_wsl2_ubuntu.sh
chmod 755 /tmp/docker_wsl2_ubuntu.sh
/tmp/docker_wsl2_ubuntu.sh

##################################
####   Configure Home Bash    ####
##################################
for d in /home/*; do
  echo "cd /mnt/d/Code" >>/home/"${d:6}"/.bashrc
done
echo "cd /mnt/d/Code" >>~/.bashrc

##################################
####    FIX DOCKER STARTUP    ####
##################################
for d in /home/*; do
  echo 'if [[ $(service docker status) != *"Docker is running"* ]]; then' >>/home/"${d:6}"/.bashrc
  echo 'sudo service docker start' >>/home/"${d:6}"/.bashrc
  echo 'fi' >>/home/"${d:6}"/.bashrc
done
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
apt update
apt install git zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
for d in /home/*; do
  cp -r ~/.oh-my-zsh/ /home/"${d:6}"/.oh-my-zsh
  cp ~/.zshrc /home/"${d:6}"/.zshrc
  chown ${d:6}:${d:6} -R /home/"${d:6}"/.oh-my-zsh
  chown ${d:6}:${d:6} -R /home/"${d:6}"/.zshrc
done
