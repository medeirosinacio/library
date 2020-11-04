#!/usr/bin/env bash
# chmod 755 ./wsl2_startup.sh

##################################
####        CHECK ROOT        ####
##################################
if [ "$EUID" -ne 0 ]; then
  printf "ERRO: Please run as root \n"
  exit 1
fi

##################################
####        GET OS            ####
##################################
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

##################################
####        CHECK OS          ####
##################################

### UBUNTU
if [ "$DISTRO" == "Ubuntu" ]; then
  curl https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/wsl/ubuntu.sh >/tmp/ubuntu.sh
  chmod 755 /tmp/ubuntu.sh
  /tmp/ubuntu.sh
  exit
fi

printf "ERRO: OS not supported. \n"
exit 1
