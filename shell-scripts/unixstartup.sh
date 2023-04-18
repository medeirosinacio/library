#!/usr/bin/env bash
# curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/unixstartup.sh > /tmp/unixstartup.sh && chmod 755 /tmp/unixstartup.sh && /tmp/unixstartup.sh

curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/functions/init_unixstartup.sh >/tmp/init_unixstartup.sh && chmod 755 /tmp/init_unixstartup.sh
INIT="/tmp/init_unixstartup.sh"
source "$INIT"

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

if [ "$DISTRO" == "Ubuntu" ]; then
  ./distros-init/ubuntu.sh $parameters
  exit
fi

if [ "$DISTRO" == "debian" ]; then
  ./distros-init/ubuntu.sh $parameters
  exit
fi

printf "ERRO: OS not supported. $DISTRO"
exit 1
