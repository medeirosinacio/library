#!/usr/bin/env bash
# curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install/docker_ubuntu.sh > /tmp/ub.sh && chmod 755 /tmp/ub.sh && /tmp/ub.sh

curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/functions/init_unixstartup.sh >/tmp/init_unixstartup.sh && chmod 755 /tmp/init_unixstartup.sh
INIT="/tmp/init_unixstartup.sh"
source "$INIT"

sudo apt update -y
sudo apt upgrade -y

sudo apt install git net-tools nmap tree dos2unix -y

# fiz unix encode
dos2unix ./*/* >/dev/null 2>&1

if [[ ! -z $wsl ]]; then
  ./functions/sshclone.sh $parameters
  ./functions/wslconf.sh $parameters
fi

./install/docker_ubuntu.sh $parameters

./install/zsh_ubuntu.sh $parameters

# Configure init.d /etc/init.d/startup.sh
FILE_STARTUP=/etc/init.d/startup.sh
if [ ! -f "$FILE_STARTUP" ]; then
  sudo touch "$FILE_STARTUP"
fi

PARAMS_INIT_SCRIPT=(
  '#!/usr/bin/env bash'
  'if [[ $(sudo service docker status) != *"Docker is running"* ]]; then sudo service docker start >/dev/null 2>&1; fi'
)

sudo chmod 777 /etc/init.d/startup.sh
for param in "${PARAMS_INIT_SCRIPT[@]}"; do
  if ! cat "$FILE_STARTUP" | grep -xqFe "$param"; then
    sudo echo "$param" >>"$FILE_STARTUP"
  fi
done

if [[ ! -z $wsl ]]; then
  # Set script /etc/init.d/startup.sh on load terminal
  if ! cat ~/.bashrc | grep -xqFe 'if [ -f /etc/init.d/startup.sh ]; then  /etc/init.d/startup.sh; fi'; then
    sudo echo 'if [ -f /etc/init.d/startup.sh ]; then  /etc/init.d/startup.sh; fi' >>~/.bashrc
  fi
fi
sudo chmod 755 /etc/init.d/startup.sh

PARAMS_SUDO=(
  "$USER ALL=NOPASSWD:/usr/sbin/service docker start"
  "$USER ALL=NOPASSWD:/usr/sbin/service docker status"
  "$USER ALL=NOPASSWD:/usr/sbin/service docker stop"
)
FILE_SUDO=/etc/sudoers
for param in "${PARAMS_SUDO[@]}"; do
  if ! sudo cat "$FILE_SUDO" | grep -xqFe "$param"; then
    echo "$param" | sudo EDITOR='tee -a' visudo
  fi
done

if [[ ! -z $user ]]; then
  RESPONSE=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "https://raw.githubusercontent.com/$user/library/master/conf/unixstartup/.bashrc_aliases")
  if [[ "$RESPONSE" == 200 ]]; then
    curl -fsSL "https://raw.githubusercontent.com/$user/library/master/conf/unixstartup/.bashrc_aliases" >~/.bashrc_aliases
    dos2unix ~/.bashrc_aliases >/dev/null 2>&1
  fi
fi

if [[ ! -z $user ]]; then
  RESPONSE=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "https://raw.githubusercontent.com/$user/library/master/conf/unixstartup/custom_conf.sh")
  if [[ "$RESPONSE" == 200 ]]; then
    curl -fsSL "https://raw.githubusercontent.com/$user/library/master/conf/unixstartup/custom_conf.sh" >/tmp/custom_conf.sh
    dos2unix /tmp/custom_conf.sh >/dev/null 2>&1
    chmod 755 /tmp/custom_conf.sh
    /tmp/custom_conf.sh
  fi
fi
