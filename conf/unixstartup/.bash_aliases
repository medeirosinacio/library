# docker
alias dockerup="docker-compose up -d --force-recreate --build --remove-orphans"
alias dockerdown="docker-compose down "
alias dockerex="docker exec -it "
alias dockerstop="docker ps -q | xargs -r docker stop"
alias update-all="sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y"
alias amaterasu="echo \"docker stop \\\$(docker ps -aq) && docker rm \\\$(docker ps -aq)\""

# docker bin
alias artisan='docker run -ti --rm -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD -p 8000:8000 --user $(id -u):$(id -g) vcarreira/artisan'
alias bower='docker run -ti --rm --volume  /mnt:/mnt --volume /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) vcarreira/node bower'
alias composer='docker run -ti --rm -v  /mnt:/mnt -v /home/$USER:/home/$USER -v ${COMPOSER_HOME:-$HOME/.composer}:/tmp --dns 8.8.8.8 -w $PWD --user $(id -u):$(id -g) composer'
alias composer7.0='docker run -ti --rm --dns 8.8.8.8  -v  /mnt:/mnt -v /home/$USER:/home/$USER -v ${COMPOSER_HOME:-$HOME/.composer}:${COMPOSER_HOME:-$HOME/.composer} -w $PWD --user $(id -u):$(id -g) prooph/composer:7.0'
alias gulp='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) vcarreira/node gulp '
alias npm='docker run -ti --rm --user $(id -u):$(id -g)  -v "$PWD":/usr/src/app -w /usr/src/app node:alpine npm'
alias php-sandbox='docker run --rm -it -v ./:/app -u dump --add-host host.docker.internal:"$WSL_NAMESERVER" -w /app --user $(id -u):$(id -g) dumptec/php-fpm:dev-8.2-0.1.8'
alias tinker='docker run -it --rm -v  /mnt:/mnt -v /home:/home -v $PWD:/var/www/html/pwd rtzmx/tinker'

# wsl
alias wsl-host-ip="cmd.exe /c \"ipconfig | findstr IPv\""
alias wsl-nameserver='cat /etc/resolv.conf | grep nameserver | awk "{print \$2}"'

alias storm="/mnt/c/Program\ Files/JetBrains/PhpStorm\ 2023.1/bin/phpstorm64.exe"
alias explorer="/mnt/c/Windows/explorer.exe"
alias cmd="/mnt/c/Windows/System32/cmd.exe"
alias notepad="/mnt/c/Program\ Files/Notepad++/notepad++.exe >/dev/null 2>&1"

# git
alias gitcf="git checkout -f"
alias gitc="git checkout"
alias gitfp="git fetch --all && git pull"
alias gitcb="git checkout -b"

#tools
alias create-exe-git-bashscript='if [ ! -f "/usr/share/create-exe-git-bashscript.sh" ]; then wget -q -O /usr/share/create-exe-git-bashscript.sh https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/create-exe-git-bashscript.sh; fi; bash /usr/share/create-exe-git-bashscript.sh;'

# external