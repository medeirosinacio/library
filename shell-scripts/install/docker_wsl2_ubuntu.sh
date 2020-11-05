#!/usr/bin/env bash
# chmod 755 ./docker_wsl2_ubuntu.sh
# https://medium.com/@lewwybogus/how-to-stop-wsl2-from-hogging-all-your-ram-with-docker-d7846b9c5b37

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

# Docker Install
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo apt install build-essential -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install docker-ce -y
sudo service docker start

# "systemctl enable" not working in wls, use command line in ".bashrc". hacks
sudo systemctl enable docker

# Docker compose Install
sudo apt install docker-compose -y

# add grounp and service startup
sudo usermod -aG docker $USER

# check install
printf "\n \n \n"
docker -v
printf "\n"
docker-compose --version
printf "\n"
