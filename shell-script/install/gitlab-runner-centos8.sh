#!/usr/bin/env bash
# https://docs.gitlab.com/runner/install/linux-manually.html

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

curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

chmod +x /bin/gitlab-runner

gitlab-runner install --user=deployer --working-directory=/home/deployer

gitlab-runner start
