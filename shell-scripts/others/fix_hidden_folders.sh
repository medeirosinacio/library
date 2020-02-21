#!/bin/bash
# OS: Windowns 10
# Desc: Função para ocultar pastas do sistema nomeadas conforme o array folders
# Autor: Douglas Medeiros <medeirosinacio@outlook.com>

# pastas a serem ocultadas
declare -a folders=('.vagrant' '.git' '.idea')

# Entra na partição
cd d:

# Faz a checagem se a pasta Code existe
if [ -d Code ]; then

  # Resgata as pastas e subpastas do Code com no maximo 10 subpastas
  find Code -maxdepth 10 -type d -print0 |

    # Faz loop nas pastas resgatadas
    while IFS= read -rd '' dir; do

      # Loop no array com os diretorios a ocultar
      for i in "${folders[@]}"; do

        # Caso o diretorio atual seja de mesmo nome do diretorio para ocultar
        if [[ "$dir" == *"$i" ]]; then

          # Ocultamos a pasta
          attrib +h "$dir" >>/dev/null

        fi

      done

    done

fi
