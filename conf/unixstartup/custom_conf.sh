#!/usr/bin/env bash

PARAMS_ALIAS=(
  'alias notepad="/mnt/d/Programas/Notepad++/notepad++.exe"'
  'alias phpstorm="phpstorm64.exe"'
  'alias explorer="explorer.exe"'
  'alias sigaup="cd /home/medeirosinacio/code/SIGA/siga-docker && dockerup && cd /home/medeirosinacio/code/SIGA/siga-docker/application/siga/public"'
  'alias sigadown="cd /home/medeirosinacio/code/SIGA/siga-docker && dockerdown && cd /home/medeirosinacio/code/SIGA/siga-docker/application/siga/public"'
)
for param in "${PARAMS_ALIAS[@]}"; do
  if ! cat ~/.bashrc_aliases | grep -xqFe "$param"; then
    sudo echo "$param" >>~/.bashrc_aliases
  fi
done

mkdir ~/code

clear

Y='\u001b[33;1m'
B='\u001b[34;1m'
G='\u001b[30;1m'
NC='\033[0m' # No Color
TEXT_BOLD='\e[7;49;33m'

IFS=';' read updates security_updates < <(/usr/lib/update-notifier/apt-check 2>&1)

DISTRO=$(lsb_release -d | awk '{print $2, $3}')

printf "
     ${Y}Welcome ${TEXT_BOLD}$USER${NC}${Y} to $WSL_DISTRO_NAME on Windows Subsystem for Linux (WSL2)${NC}

     System ${B}information${NC} as of $(date)

     ➤ Linux distribution:             ${G} $DISTRO   ${NC}
     ➤ Linux kernel:                   ${G} $(uname -rp)   ${NC}
     ➤ Terminal:                       ${G} $SHELL   ${NC}
     ➤ IPv4 address for eth0:          ${G} $(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)   ${NC}
     ➤ Updates available               ${G} $updates    ${NC}
     ➤ Security Updates available      ${G} $security_updates   ${NC}
"
echo -e ''
