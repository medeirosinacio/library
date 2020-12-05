#!/usr/bin/env bash

sudo rm -rf /tmp/library
git clone https://github.com/medeirosinacio/library.git /tmp/library

chmod +x /tmp/library/docker-bin-container/*
chmod 777 /tmp/library/docker-bin-container/*

sudo cp /tmp/library/docker-bin-container/* /usr/bin/