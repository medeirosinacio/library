#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "No argument for create user. create_user_pass.sh newuser JdsalkjKLAHSdaKAJ"
fi

if [ -z "$2" ]
  then
    echo "No argument for create pass. create_user_pass.sh"
fi

useradd --comment "$1" --create-home $1 -p $2 --shell /bin/bash