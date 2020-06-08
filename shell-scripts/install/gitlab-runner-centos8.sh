#!/usr/bin/env bash
# https://docs.gitlab.com/runner/install/linux-manually.html
# how to execute this:
# 1 - curl https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install/gitlab-runner-centos8.sh -o gitlab-runner-centos8.sh
# 2 - chmod +x ./gitlab-runner-centos8.sh
# 3- ./gitlab-runner-centos8.sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Check if user exists
if ! id -u "deployer" > /dev/null 2>&1; then
    echo "The user does not exist; execute below commands to crate and try again:"
    echo "  root@sh1:~# useradd --comment 'deployer' --create-home deployer -p ************* --shell /bin/bash"
    exit 1
fi

# get gitlab-runner bin
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# change permission
chmod +x /usr/local/bin/gitlab-runner

# create $PATH 
ln -s /usr/local/bin/gitlab-runner /bin/gitlab-runner

# Install gitlab-runner deployer
gitlab-runner install --user=deployer --working-directory=/home/deployer

# Start service
gitlab-runner start

# Enable on boot
systemctl enable gitlab-runner
