#!/usr/bin/env bash

clear

Y='\u001b[33;1m'
B='\u001b[34;1m'
G='\u001b[30;1m'
NC='\033[0m' # No Color

IFS=';' read updates security_updates < <(/usr/lib/update-notifier/apt-check 2>&1)

DISTRO=$(lsb_release -d | awk '{print $2, $3}')

printf  "
     ${Y}Welcome $USER to $WSL_DISTRO_NAME on Windows Subsystem for Linux (WSL2)${NC}

     System ${B}information${NC} as of $(date)

     ➤ Linux distribution:             ${G} $DISTRO   ${NC}
     ➤ Linux kernel:                   ${G} $(uname -rp )   ${NC}
     ➤ Terminal:                       ${G} $SHELL   ${NC}
     ➤ IPv4 address for eth0:          ${G} $(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)   ${NC}
     ➤ Updates available               ${G} $updates    ${NC}
     ➤ Security Updates available      ${G} $security_updates   ${NC}
"
echo ''