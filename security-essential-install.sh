#!/bin/bash

echo "Installing ufw and allowing ports 22 80 443  only "
sudo nala install ufw
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
