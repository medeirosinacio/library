# sys
alias update-all="sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y"

# docker
alias dockerup="docker-compose up -d --force-recreate --build --remove-orphans"
alias dockerdown="docker-compose down "
alias dockerex="docker exec -it "
alias dockerstop="docker ps -q | xargs -r docker stop"

# docker bin
alias artisan='docker run -ti --rm -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD -p 8000:8000 --user $(id -u):$(id -g) vcarreira/artisan'
alias bower='docker run -ti --rm --volume  /mnt:/mnt --volume /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) vcarreira/node bower'
alias composer='docker run -ti --rm -v  /mnt:/mnt -v /home/$USER:/home/$USER -v ${COMPOSER_HOME:-$HOME/.composer}:/tmp -w $PWD --user $(id -u):$(id -g) composer'
alias composer7.0='docker run -ti --rm --dns 8.8.8.8  -v  /mnt:/mnt -v /home/$USER:/home/$USER -v ${COMPOSER_HOME:-$HOME/.composer}:${COMPOSER_HOME:-$HOME/.composer} -w $PWD --user $(id -u):$(id -g) prooph/composer:7.0'
alias gulp='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) vcarreira/node gulp '
alias npm='docker run -ti --rm --user $(id -u):$(id -g)  -v "$PWD":/usr/src/app -w /usr/src/app node:alpine npm'
alias php='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) -p 80:80 -p 8000:8000 --dns 8.8.8.8 php:latest php'
alias php5.4='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) php:5.4-cli php'
alias php5.6='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) php:5.6-cli php'
alias php7.0='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) php:7.0-cli php'
alias php7.3='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) php:7.3-cli php'
alias php7.4='docker run -ti --rm  -v  /mnt:/mnt -v /home/$USER:/home/$USER -w $PWD --user $(id -u):$(id -g) php:7.4-cli php'
alias tinker='docker run -it --rm -v  /mnt:/mnt -v /home:/home -v $PWD:/var/www/html/pwd rtzmx/tinker'
alias phpstorm="phpstorm64.exe"
alias explorer="explorer.exe"
alias sigaup="cd /home/medeirosinacio/code/siga && dockerup && cd /home/medeirosinacio/code/siga/application/siga/public"
alias sigadown="cd /home/medeirosinacio/code/siga && dockerdown && cd /home/medeirosinacio/code/siga/application/siga/public"
alias cl="zsh"
alias notepad="/mnt/c/Program Files/Notepad++/notepad++.exe"
