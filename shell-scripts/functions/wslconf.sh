#!/usr/bin/env bash

if [ ! -f /etc/wsl.conf ]; then
    sudo touch /etc/wsl.conf

    sudo chmod 777 /etc/wsl.conf

cat > /etc/wsl.conf <<EOF
[boot]
command="[[ -f /etc/init.d/startup.sh ]] && sudo /etc/init.d/startup.sh"
command="echo \$(iso8601) $USER 2 wsl up >> /var/log/wsl.log"

EOF

    sudo chmod 744 /etc/wsl.conf
fi

