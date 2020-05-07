#! /bin/bash
#========================================================================
# Script name    :setup-env.sh
# Description    :This script is for setting up my dev environment in 
#                 Debian-based distros
#                 Docker instalation only work in Ubuntu or Debain
# Author         :Eduardo Betanzos Morales
# Email          :ebetanzos@hotmail.es
#
# Usage:         sudo /path/to/setup-env.sh
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


# Update system
#---------------------------------------------------------------
echo "Update system"
echo "    Packages list"
echo "    --------------------------------------------------------------"
apt update
echo "    Installed packages"
echo "    --------------------------------------------------------------"
apt upgrade -y


# Tools and programs
#---------------------------------------------------------------
echo "Install tools and programs"
echo "    Install curl"
echo "    --------------------------------------------------------------"
apt install curl -y
echo "    Install nano"
echo "    --------------------------------------------------------------"
apt install nano -y
echo "    Install gnome-tweaks"
echo "    --------------------------------------------------------------"
apt install gnome-tweaks -y
echo "    Install dconf-editor"
echo "    --------------------------------------------------------------"
apt install dconf-editor -y
echo "    Install vlc"
echo "    --------------------------------------------------------------"
apt install vlc -y
echo "    Install ffmpeg"
echo "    --------------------------------------------------------------"
apt install ffmpeg -y
echo "    Install qbittorrent"
echo "    --------------------------------------------------------------"
apt install qbittorrent -y
echo "    Install youtube-dl"
echo "    --------------------------------------------------------------"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
echo "    Install gnome-boxes"
echo "    --------------------------------------------------------------"
apt install gnome-boxes -y
echo "    Install gimp"
echo "    --------------------------------------------------------------"
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo apt update
sudo apt install gimp -y


# Dev tools
#---------------------------------------------------------------
echo "Setting up dev environment"
## Git
echo "    Install git"
echo "    --------------------------------------------------------------"
apt install git -y
echo "        Setting up git"
echo "    --------------------------------------------------------------"
git config --global user.name "Eduardo Betanzos"
git config --global user.email "ebetanzos@hotmail.es"
git config --global core.autocrlf input
git config --global core.editor nano
git config --global core.excludesfile ~/.gitignore_global
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.lone 'log --oneline'
git config --global alias.lds 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=short'
git config --global alias.ldr 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%cn]" --decorate --date=relative'
### Download global .gitignore
curl -sS https://raw.githubusercontent.com/betanzos/my-scripts/master/git/.gitignore_global -o $HOME/.gitignore_global

## Docker
echo "    Install docker"
echo "    --------------------------------------------------------------"
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install -y apt-transport-https ca-certificates software-properties-common

if cat /etc/*release | grep ^NAME | grep Debian; then
    echo "        Preparing docker instalation for Debian"
    echo "--------------------------------------------------------------"
    apt install -y gnupg2
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"	
    echo "        END DEBIAN CONFIG ------------------------------------"
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "        Preparing docker instalation for Ubuntu"
    echo "--------------------------------------------------------------"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"	
    echo "        END UBUNTU CONFIG ------------------------------------"
fi

sudo apt update
sudo apt install -y docker-ce
### Run my containers
echo "        Docker containers"
echo "    --------------------------------------------------------------"
#### Postgres 9.6
echo "            - postgres9.6"
echo "    --------------------------------------------------------------"
docker run --name postgres9.6 -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:9.6-alpine

## pgAdmin III
echo "    Install pgadminIII"
echo "    --------------------------------------------------------------"
apt install -y pgadmin3 --no-install-recommends

echo
echo
echo "-------------------------------------------------------------------"
echo "SUCCESSFUL!!"
