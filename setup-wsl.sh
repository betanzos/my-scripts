#!/bin/bash
#========================================================================
# Script name    :setup-wsl.sh
# Description    :This script is for setting up my dev environment in 
#                 Debian-based WSL distros
# Author         :Eduardo Betanzos Morales
# Email          :ebetanzos@hotmail.es
#
# Usage:         sh -c "$(curl -sSL https://raw.githubusercontent.com/betanzos/my-scripts/master/setup-wsl.sh)"
#                      [<maven-settings-file>]
#
#
# Copyright © 2020  Eduardo Betanzos Morales 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#========================================================================


# Prevent run as root because since Ubuntu 20.04 when use root to execute
# the script $HOME points to /root instead current user home dir
if [[ $EUID -eq 0 ]]; then
    echo "[ERROR] This script should not be run using Sudo or as the root user"
	echo
    exit 1
fi

# Show sudo login in terminal
sudo -i echo

if [ ! $? -eq 0 ]; then
    echo
    echo "[ERROR] Bad password"
    echo
    exit 1
fi

echo


# Update system packages
#---------------------------------------------------------------
echo "UPDATE SYSTEM"
echo
echo "Packages list"
echo "--------------------------------------------------------------"
sudo apt update
echo
echo "Installed packages"
echo "--------------------------------------------------------------"
sudo apt upgrade -y


# General settings
#---------------------------------------------------------------
echo
echo
echo "GENERAL SETTINGS"
echo
ALIAS_DEST=$HOME/.profile
echo "" >> $ALIAS_DEST
echo "" >> $ALIAS_DEST

echo "  - Make alias 'll' as 'ls -lha'"
#    --------------------------------------------------------------
echo "" >> $ALIAS_DEST
echo "" >> $ALIAS_DEST
echo "alias ll='ls -lha'" >> $ALIAS_DEST
echo
echo "  - Specify automount with metadata option"
#    --------------------------------------------------------------
sudo touch /etc/wsl.conf
sudo chmod 666 /etc/wsl.conf
echo "[automount]" >> /etc/wsl.conf
echo "options=metadata" >> /etc/wsl.conf
sudo chmod 644 /etc/wsl.conf


# Environment variables
#---------------------------------------------------------------
echo
echo
echo "ENVIRONMENT VARIABLES"
echo
ENV_DEST=$HOME/.profile
echo "" >> $ENV_DEST
echo "" >> $ENV_DEST

echo "[INFO] Environment variables will be defined in $ENV_DEST"
echo
echo "  - Setting up DISPLAY"
#    --------------------------------------------------------------
echo "DISPLAY=:0" >> $ENV_DEST

echo "  - Setting up LIBGL_ALWAYS_INDIRECT"
#    --------------------------------------------------------------
echo "LIBGL_ALWAYS_INDIRECT=1" >> $ENV_DEST

echo "  - Setting up GPG_TTY"
#    --------------------------------------------------------------
echo "GPG_TTY=$(tty)" >> $ENV_DEST


# Packages
#---------------------------------------------------------------
echo
echo
echo "INSTALL PACKAGES"
echo
echo "Install binutils"
echo "--------------------------------------------------------------"
sudo apt install binutils -y


# Tools and programs
#---------------------------------------------------------------
echo
echo
echo "TOOLS AND PROGRAMS"
echo
echo "Install neofetch"
echo "--------------------------------------------------------------"
sudo apt install neofetch -y
echo
echo "Install curl"
echo "--------------------------------------------------------------"
sudo apt install curl -y
echo
echo "Install ffmpeg"
echo "--------------------------------------------------------------"
sudo apt install ffmpeg -y
echo
echo "Install youtube-dl"
echo "--------------------------------------------------------------"
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
echo
echo "Install zip"
echo "--------------------------------------------------------------"
sudo apt install zip -y
echo
echo "Install unzip"
echo "--------------------------------------------------------------"
sudo apt install unzip -y


# Dev environment
#---------------------------------------------------------------
echo
echo
echo "DEV ENVIRONMENT"
echo
## Git
echo "Install git"
echo "--------------------------------------------------------------"
sudo apt install git -y
echo
echo "Setting up git"
echo "--------------------------------------------------------------"
echo "  - Global configuration"
git config --global user.name "Eduardo Betanzos"
git config --global user.email "ebetanzos@hotmail.es"
git config --global core.autocrlf input
git config --global core.editor nano
git config --global core.excludesfile ~/.gitignore_global
git config --global core.fileMode false
echo "  - Making aliases"
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.lone 'log --oneline'
git config --global alias.lds 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=short'
git config --global alias.ldr 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=relative'
### Download global .gitignore
echo "  - Global ignore rules"
curl -sS https://raw.githubusercontent.com/betanzos/my-scripts/master/git/.gitignore_global -o $HOME/.gitignore_global

## SDKMAN
echo
echo "Install sdkman"
echo "---------------------------------------------------------------------"
curl -s "https://get.sdkman.io" | bash
chmod -R 777 $HOME/.sdkman
. $HOME/.sdkman/bin/sdkman-init.sh

## Install latest LTS JDK
echo
echo "Install latest LTS JDK"
echo "---------------------------------------------------------------------"
sdk install java

## Install latest Apache Maven
echo
echo "Install latest Apache Maven"
echo "---------------------------------------------------------------------"
sdk install maven
MVN_SETTINGS="/mnt/d/tools/global_settings/maven/settings-wsl.xml"
if [[ $1 && -f $1 ]]; then
    MVN_SETTINGS=$1
fi
cp $MVN_SETTINGS $HOME/.sdkman/candidates/maven/current/conf/settings.xml

## Packages for run JavaFX applications
echo
echo "Install needed packages for run JavaFX applications"
echo "---------------------------------------------------------------------"
sudo apt install -y libgtk-3-0 libglu1-mesa
# According JavaFX official site (how to build javafx)
#apt install -y libgtk-3-0 libgl1-mesa-glx libx11-6 x11proto-core-dev 
echo
echo
echo "-------------------------------------------------------------------"
echo "FINISH!!"
echo
echo "Please open a new terminal"
echo
