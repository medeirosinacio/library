#!/bin/bash
# OS: Windowns 10
# Desc: Synchronize git repositories bash script
# Autor: Douglas Medeiros <medeirosinacio@outlook.com>
# Exemple to use: ./sync_repository.sh https://oauth2:XXXxxxXXXxxXXX@gitlab.com:name/repo.git git@gitlab.com:name/repo.git

DATE=$(date +"%d-%m-%Y-%H-%M-%S-%s")
FOLDER_TEMP="sync_repository-${DATE}"

# exemple https token: https://oauth2:XXXxxxXXXxxXXX@gitlab.com:name/repo.git
ORIGIN=${1}

# exemple ssh key: git@gitlab.com:name/repo.git
DESTINATION=${2}

echo "Create temp folder... $FOLDER_TEMP"
mkdir -p $FOLDER_TEMP
cd $FOLDER_TEMP

echo "Clone repository origin..."
git clone $ORIGIN .
for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
  git branch --track "${branch##*/}" "$branch"
done
git fetch --all
git pull --all

echo "Sync repository destination..."
git remote set-url origin $DESTINATION
git push origin --all
git push origin --tags
git push --force --all
git push --force --tags
cd ../
rm -rf $FOLDER_TEMP
