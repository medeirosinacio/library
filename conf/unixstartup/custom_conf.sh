#!/usr/bin/env bash

mkdir ~/code >>/dev/null 2>&1

# WELCOME
FILE_STARTUP=/etc/init.d/startup.sh
PARAMS_INIT_SCRIPT=(
  'if [[ -f /usr/share/welcome.sh ]]; then /usr/share/welcome.sh; fi'
)
sudo chmod 777 /etc/init.d/startup.sh
for param in "${PARAMS_INIT_SCRIPT[@]}"; do
  if ! cat "$FILE_STARTUP" | grep -xqFe "$param"; then
    sudo echo "$param" >>"$FILE_STARTUP"
  fi
done
sudo chmod 755 /etc/init.d/startup.sh

sudo rm /usr/share/welcome.sh
sudo touch /usr/share/welcome.sh
sudo chmod 777 /usr/share/welcome.sh

cat <<EOF >/usr/share/welcome.sh
#!/usr/bin/env bash

clear

Y='\u001b[33;1m'
B='\u001b[34;1m'
G='\u001b[30;1m'
NC='\033[0m' # No Color
TEXT_BOLD='\e[7;49;33m'

sudo bash -c 'apt update >/dev/null 2>&1 & disown'

IFS=';' read updates security_updates < <(/usr/lib/update-notifier/apt-check 2>&1)

DISTRO=\$(lsb_release -d | awk '{print \$2, \$3}')
DISTRO_NAME=\$(lsb_release -d | awk '{print \$2}')

printf "
     \${Y}Welcome \${TEXT_BOLD}\$USER\${NC}\${Y} to \$DISTRO_NAME on Windows Subsystem for Linux (WSL2)\${NC}

     System \${B}information\${NC} as of \$(date)

     ➤ Linux distribution:             \${G} \$DISTRO   \${NC}
     ➤ Linux kernel:                   \${G} \$(uname -rp)   \${NC}
     ➤ Terminal:                       \${G} /usr/bin/zsh   \${NC}
     ➤ IPv4 address for eth0:          \${G} \$(ip addr show eth0 | grep "inet\b" | awk '{print \$2}' | cut -d/ -f1)   \${NC}
     ➤ Updates available               \${G} \$updates    \${NC}
     ➤ Security Updates available      \${G} \$security_updates   \${NC}

"

EOF

sudo chown root:root /usr/share/welcome.sh
sudo chmod 555 /usr/share/welcome.sh
/usr/share/welcome.sh
# ./WELCOME

