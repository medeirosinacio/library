#!/bin/bash
# OS: Windowns 10
# Desc: Rename all files to randon string. PS: preserve extension
# Autor: Douglas Medeiros <medeirosinacio@outlook.com>
# Exemple to use: ./randon_name_files_folder.sh "/c/Users/Douglas Medeiros/Music/Spotify Donw"

FOLDER=${1}

# How to use:
#  generateRandomString RESULT
#  echo $RESULT
function generateRandomString() {

  local -n VAR=$1
  characters='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  string_length=25

  string=''

  x=1
  while [ $x -le $string_length ]; do

    possition=$((1 + RANDOM % 61))
    string="${string}${characters:${possition}:1}"
    x=$(($x + 1))

  done

  VAR=$string

}

# Faz a checagem se a pasta Code existe
if [ -d "${FOLDER}" ]; then

  cd "${FOLDER}" || exit

  for f in *.*; do

    filename=$(basename -- "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"

    generateRandomString RESULT
    echo "Rename $f to $RESULT.$extension..."
    mv "$f" "$RESULT.$extension"

  done

fi