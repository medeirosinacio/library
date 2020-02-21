#!/bin/bash
# OS: Windowns 10
# Desc: Função para ocultar pastas do sistema nomeadas conforme o array folders_hide
# Autor: Douglas Medeiros <medeirosinacio@outlook.com>

# Pasta de trabalho
declare -a folder=("/d/Code")

# pastas a serem ocultadas
declare -a folders_hide=('.vagrant' '.git' '.idea')

# Faz a checagem se a pasta Code existe
if [ -d "$folder" ]; then

  # Resgata as pastas e subpastas do Code com no maximo 10 subpastas
  find "$folder" -maxdepth 10 -type d -print0 |

    # Faz loop nas pastas resgatadas
    while IFS= read -rd '' dir; do

      # Loop no array com os diretorios a ocultar
      for i in "${folders_hide[@]}"; do

        # Caso o diretorio atual seja de mesmo nome do diretorio para ocultar
        if [[ "$dir" == *"$i" ]]; then

          # Ocultamos a pasta e ocultamos a saida do terminal
          attrib +h "$dir" >>/dev/null

        fi

      done

    done

fi
