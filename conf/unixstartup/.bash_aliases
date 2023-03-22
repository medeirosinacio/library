alias update-all="sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y"
alias create-exe-git-bashscript="/usr/share/create-exe-git-bashscript.sh"

# docker
alias dockerup="docker-compose up -d --force-recreate --build --remove-orphans"
alias dockerdown="docker-compose down "
alias dockerex="docker exec -it "
alias dockerstop="docker ps -q | xargs -r docker stop"
alias amaterasu="echo \"docker stop \\\$(docker ps -aq) && docker rm \\\$(docker ps -aq)\""

# git
alias gitcf="git checkout -f"
alias gitc="git checkout"
alias gitfp="git fetch && git pull"
alias gitcb="git checkout -b"

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

alias bumaup="cd ~/code/fipo-bot-php-generic/bin/ && ./build-and-up.sh && cd .."
alias nivyup="cd ~/code/fipo-gerenciador-nivy/bin/ && ./build-and-up.sh && cd .."