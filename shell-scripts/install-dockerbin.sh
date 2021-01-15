#!/usr/bin/env bash

sudo rm -rf /tmp/library
git clone https://github.com/medeirosinacio/library.git /tmp/library

sed -i -e 's/^M$//' /tmp/library/docker-bin-container/*
sed -i -e 's/\r$//' /tmp/library/docker-bin-container/*

chmod +x /tmp/library/docker-bin-container/*
chmod 777 /tmp/library/docker-bin-container/*

sudo cp /tmp/library/docker-bin-container/* /usr/bin/