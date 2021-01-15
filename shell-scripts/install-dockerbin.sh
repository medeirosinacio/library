#!/usr/bin/env bash
# curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/shell-scripts/install-dockerbin.sh > /tmp/install-dockerbin.sh && chmod 755 /tmp/install-dockerbin.sh && /tmp/install-dockerbin.sh

sudo rm -rf /tmp/library
git clone https://github.com/medeirosinacio/library.git /tmp/library

sed -i -e 's/^M$//' /tmp/library/docker-bin-container/*
sed -i -e 's/\r$//' /tmp/library/docker-bin-container/*

chmod +x /tmp/library/docker-bin-container/*
chmod 777 /tmp/library/docker-bin-container/*

sudo cp /tmp/library/docker-bin-container/* /usr/bin/
