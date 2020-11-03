#!/usr/bin/env bash
# chmod 755 ./wsl2_startup.sh

# Ckeck root
if [ "$EUID" -ne 0 ]; then
  printf "ERRO: Please run as root \n"
  exit 1
fi

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
  # If available, use LSB to identify distribution
  if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
    export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
  # Otherwise, use release info file
  else
    export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
  fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME
# Check OS
if [ "$DISTRO" != "Ubuntu" ]; then
  printf "ERRO: OS not supported. Installation only for Ubuntu. \n"
  exit 1
fi

apt update -y
apt upgrade -y
apt install net-tools

# Install docker and docker-compose
curl https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install/docker_wsl2_ubuntu.sh >/tmp/docker_wsl2_ubuntu.sh
chmod 755 /tmp/docker_wsl2_ubuntu.sh
/tmp/docker_wsl2_ubuntu.sh

# Configure Home Bash
for d in /home/*; do
  echo "cd /mnt/d/Code" >>/home/"${d:6}"/.bashrc
done
echo "cd /mnt/d/Code" >>~/.bashrc
