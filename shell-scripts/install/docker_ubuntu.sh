#!/usr/bin/env bash
# curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install/docker_ubuntu.sh > /tmp/docker_ubuntu.sh && chmod 755 /tmp/docker_ubuntu.sh && /tmp/docker_ubuntu.sh
# https://medium.com/@lewwybogus/how-to-stop-wsl2-from-hogging-all-your-ram-with-docker-d7846b9c5b37

curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/functions/init_unixstartup.sh >/tmp/init_unixstartup.sh && chmod 755 /tmp/init_unixstartup.sh
INIT="/tmp/init_unixstartup.sh"
source "$INIT"

# Docker Install
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common build-essential -y
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

# If WSL set docker API :4444
if [[ ! -z $wsl ]]; then
  FILE=/etc/default/docker
  DOCKER_API="DOCKER_OPTS='-H tcp://0.0.0.0:4445 -H unix:///var/run/docker.sock'"
  if [ -f "$FILE" ]; then
    sudo chmod 777 /etc/default/docker
    if ! cat "$FILE" | grep -xqFe "$DOCKER_API"; then
      echo "$DOCKER_API" >>"$FILE"
    fi
    sudo chmod 644 /etc/default/docker
  fi
fi

sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop
