#!/usr/bin/env bash

alias composer="docker run -t --rm --interactive --volume \$PWD/:/app --volume \${COMPOSER_HOME:-\$HOME/.composer}:/tmp --user \$(id -u):\$(id -g) composer"
alias artisan="docker run -t --rm -v \$(pwd):/var/www vcarreira/artisan"
alias php="docker run -t --rm --interactive --volume \$PWD/:/app -w /app --user \$(id -u):\$(id -g) php:7.4-cli php"
alias npm="docker run -t --rm -v \$(pwd):/var/www vcarreira/node npm"
alias gulp="docker run -t --rm -v \$(pwd):/var/www vcarreira/node gulp"
alias bower="docker run -t --rm -v \$(pwd):/var/www vcarreira/node bower"