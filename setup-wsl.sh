#!/bin/bash
#========================================================================
# Script name    :setup-wsl.sh
# Description    :This script is for setting up my dev environment in 
#                 Debian-based WSL distros
# Author         :Eduardo Betanzos Morales
# Email          :ebetanzos@hotmail.es
#
# Usage:         sudo sh -c "$(curl -sSL https://raw.githubusercontent.com/betanzos/my-scripts/master/setup-wsl.sh)"
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

# Update system packages
#---------------------------------------------------------------
echo "UPDATE SYSTEM"
echo
echo "Packages list"
echo "--------------------------------------------------------------"
apt update
echo
echo "Installed packages"
echo "--------------------------------------------------------------"
apt upgrade -y


# General settings
#---------------------------------------------------------------
echo
echo
echo "GENERAL SETTINGS"
echo
echo "Make alias 'll' for 'ls -lha'"
echo "--------------------------------------------------------------"
echo " " >> $HOME/.bashrc
echo " " >> $HOME/.bashrc
echo "alias ll='ls -lha'" >> $HOME/.bashrc
echo
echo "Specify automount with metadata option"
echo "--------------------------------------------------------------"
echo "[automount]" >> /etc/wsl.conf
echo "options=metadata" >> /etc/wsl.conf


# Environment variables
#---------------------------------------------------------------
echo
echo
echo "ENVIRONMENT VARIABLES"
echo
echo "Setting up DISPLAY"
echo "--------------------------------------------------------------"
echo "DISPLAY=:0" >> $HOME/.bashrc
echo
echo "Setting up LIBGL_ALWAYS_INDIRECT"
echo "--------------------------------------------------------------"
echo "LIBGL_ALWAYS_INDIRECT=1" >> $HOME/.bashrc


# Packages
#---------------------------------------------------------------
echo
echo
echo "INSTALL PACKAGES"
echo
echo "Install binutils"
echo "--------------------------------------------------------------"
apt install binutils -y


# Tools and programs
#---------------------------------------------------------------
echo
echo
echo "TOOLS AND PROGRAMS"
echo
echo "Install neofetch"
echo "--------------------------------------------------------------"
apt install neofetch -y
echo
echo "Install curl"
echo "--------------------------------------------------------------"
apt install curl -y
echo
echo "Install ffmpeg"
echo "--------------------------------------------------------------"
apt install ffmpeg -y
echo
echo "Install youtube-dl"
echo "--------------------------------------------------------------"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
echo
echo "Install zip"
echo "--------------------------------------------------------------"
apt install zip -y
echo
echo "Install unzip"
echo "--------------------------------------------------------------"
apt install unzip -y


# Dev environment
#---------------------------------------------------------------
echo "DEV ENVIRONMENT"
echo
## Git
echo "Install git"
echo "--------------------------------------------------------------"
apt install git -y
echo
echo "Setting up git"
echo "--------------------------------------------------------------"
git config --global user.name "Eduardo Betanzos"
git config --global user.email "ebetanzos@hotmail.es"
git config --global core.autocrlf input
git config --global core.editor nano
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.lone 'log --oneline'
git config --global alias.lds 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=short'
git config --global alias.ldr 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=relative'

## SDKMAN
echo
echo "Install sdkman"
echo "---------------------------------------------------------------------"
curl -s "https://get.sdkman.io" | bash
chmod -R 777 $HOME/.sdkman
sleep 0.5
. "$HOME/.sdkman/bin/sdkman-init.sh"

## Install latest LTS JDK
echo
echo "Install latest LTS SDK"
echo "---------------------------------------------------------------------"
sdk install java

## Install latest Apache Maven
echo
echo "Install latest Apache Maven"
echo "---------------------------------------------------------------------"
sdk install maven
cp /mnt/d/tools/maven/settings.xml $HOME/.sdkman/candidates/maven/current/conf/settings.xml

## Packages for run JavaFX applications
echo
echo "Install needed packages for run JavaFX applications"
echo "---------------------------------------------------------------------"
apt install -y libgtk-3-0 libglu1-mesa
# According JavaFX official site (how to build javafx)
#apt install -y libgtk-3-0 libgl1-mesa-glx libx11-6 x11proto-core-dev 

## Source changes
echo
echo "Applaying changes in $HOME/.bashrc"
echo "--------------------------------------------------------------"
. $HOME/.bashrc

echo
echo
echo "-------------------------------------------------------------------"
echo "FINISH"
