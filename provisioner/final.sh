#!/bin/bash
set -e

readonly USER_NAME=$1
apt-get update
apt-get -y upgrade
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME
reboot

echo -e "finished..."