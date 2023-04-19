#!/usr/bin/env bash

red='\u001b[31m'
green='\u001B[32m'
yellow='\u001b[33m'
reset="\\033[0m \n"

action="atualizado"


if [ $# -eq 0 ]
  then
    printf "${red}É preciso informar o nome do arquivo${reset}"
    exit 1
fi

if [ ! -f "$1" ]; then
    printf "${yellow}Criando arquivo...${reset}"
    echo "#!/usr/bin/env bash" > "$1"
    action="criado"
fi

printf "${yellow}Adicionando arquivo ao git...${reset}"
git add "$1"
printf "${yellow}Adicionando permissão no sistema...${reset}"
chmod +x $1
printf "${yellow}Adicionando permissão de execução no git...${reset}"
git update-index --chmod=+x "$1"

printf "${1}${reset}"
printf "${green}Arquivo ${action} e adicionado permissões de execução no git!!!${reset}"