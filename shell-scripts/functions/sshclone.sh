#!/usr/bin/env bash

if [ ! -f ~/.ssh/id_rsa ]; then
  if [ -f /mnt/c/Users/$USER/.ssh/id_rsa ]; then

    sudo rm -rf ~/.ssh
    sudo cp -r /mnt/c/Users/$USER/.ssh ~/.ssh

    sudo chown $USER:$USER -R ~/.ssh
    sudo chown $USER:$USER -R ~/.ssh/*

    sudo chmod 700 ~/.ssh > /dev/null 2>&1
    sudo chmod 644 ~/.ssh/authorized_keys > /dev/null 2>&1
    sudo chmod 644 ~/.ssh/known_hosts > /dev/null 2>&1
    sudo chmod 644 ~/.ssh/config > /dev/null 2>&1
    sudo chmod 600 ~/.ssh/id_rsa > /dev/null 2>&1
    sudo chmod 644 ~/.ssh/id_rsa.pub > /dev/null 2>&1

  fi
fi

