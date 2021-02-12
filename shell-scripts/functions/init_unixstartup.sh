#!/usr/bin/env bash
# Script parameters in Bash
# https://stackoverflow.com/questions/18003370/script-parameters-in-bash
for ((i = 1; i <= $#; i++)); do

  if [[ ${!i} = "--help" ]]; then
    helpmsg="
          --local                : Use local repository to load scripts
          --wsl                  : Configure compatible WSL 2
          --user                 : Get custom conf [--user gitUserName]
    "

  elif [[ ${!i} = "--local" ]]; then
    localfiles=${!i}

  elif [[ ${!i} = "--wsl" ]]; then
    wsl=${!i}

  elif [[ ${!i} = "--user" ]]; then
    ((i++))
    user=${!i}

  elif [[ ${!i} != "" && ${!i} != null && ${!i} != 0 ]]; then
    echo "Invalid argument: ${!i}. Try --help"
    exit 1

  fi

done
if [[ ! -z $helpmsg ]]; then
  echo $helpmsg
  exit 1
fi

# Validade local files
if [[ -z $localfiles ]]; then
  sudo rm -rf /tmp/library
  git clone https://github.com/medeirosinacio/library /tmp/library
  cd /tmp/library/shell-scripts
  localfiles="--local"
fi

# Validade repository
if [[ "medeirosinacio/library" != $(git config --get remote.origin.url | sed 's/.*\/\([^ ]*\/[^.]*\).*/\1/') ]]; then
  echo "No scripts found!!! Please check repository location or try: --local"
  exit 1
fi

parameters="${localfiles} ${wsl} $(if [[ ! -z $user ]]; then echo "--user " $user; fi)"
