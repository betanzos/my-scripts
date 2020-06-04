#! /bin/bash
#========================================================================
# Script name    :setup-env.sh
# Description    :This script is for setting up my dev environment in
#                 Debian-based distros
#
#                 Notes:
#                  - For Ubuntu 20.04 and higher
#                  - Docker instalation only work in Ubuntu or Debain
#
# Author         :Eduardo Betanzos Morales
# Email          :ebetanzos@hotmail.es
#
# Usage:         sh -c "$(curl -sSL https://raw.githubusercontent.com/betanzos/my-scripts/master/setup-env.sh)"
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


# Update system
#---------------------------------------------------------------
echo "Update system"
echo "    Packages list"
echo "    --------------------------------------------------------------"
sudo apt update
echo
echo "    Installed packages"
echo "    --------------------------------------------------------------"
sudo apt upgrade -y


# Tools and programs
#---------------------------------------------------------------
echo
echo
echo "TOOLS AND PROGRAMS"
echo "    Install curl"
echo "    --------------------------------------------------------------"
sudo apt install curl -y
echo
echo "    Install nano"
echo "    --------------------------------------------------------------"
sudo apt install nano -y
echo
echo "    Install vlc"
echo "    --------------------------------------------------------------"
sudo apt install vlc -y
echo
echo "    Install ffmpeg"
echo "    --------------------------------------------------------------"
sudo apt install ffmpeg -y
echo
echo "    Install qbittorrent"
echo "    --------------------------------------------------------------"
sudo apt install qbittorrent -y
echo
echo "    Install youtube-dl"
echo "    --------------------------------------------------------------"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
echo
echo "    Install gimp"
echo "    --------------------------------------------------------------"
sudo apt install gimp -y


## Tools only for GNOME
if [ "${XDG_CURRENT_DESKTOP,,}" = "gnome" ]; then
    echo
    echo "    Install gnome-tweaks"
    echo "    --------------------------------------------------------------"
    sudo apt install gnome-tweaks -y
    echo
    echo "    Install dconf-editor"
    echo "    --------------------------------------------------------------"
    sudo apt install dconf-editor -y
    echo
    echo "    Install gnome-boxes"
    echo "    --------------------------------------------------------------"
    sudo apt install gnome-boxes -y
fi


# Dev tools
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
git config --global alias.lds 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%an]" --decorate --date=short'
git config --global alias.ldr 'log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [%an]" --decorate --date=relative'
git config --global alias.tree 'log --graph --oneline --all'
### Download global .gitignore
echo "  - Global ignore rules"
curl -sS https://raw.githubusercontent.com/betanzos/my-scripts/master/git/.gitignore_global -o $HOME/.gitignore_global

## SDKMAN
echo
echo "Install sdkman"
echo "---------------------------------------------------------------------"
curl -s "https://get.sdkman.io" | bash
sudo chmod -R 777 $HOME/.sdkman
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

## Docker
echo
echo "Install docker"
echo "--------------------------------------------------------------"
sudo apt remove docker docker-engine docker.io containerd runc

if cat /etc/*release | grep ^NAME | grep Debian; then
    sudo apt install -y apt-transport-https ca-certificates software-properties-common
    echo "    Preparing docker instalation for Debian"
    echo "--------------------------------------------------------------"
    sudo apt install -y gnupg2
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    echo "    END DEBIAN CONFIG ------------------------------------"
    sudo apt update
    sudo apt install -y docker-ce
elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    sudo apt install -y docker.io
    sudo usermod -aG docker $USER
fi


### Run my containers
echo
echo "Docker containers"
echo "--------------------------------------------------------------"
#### Postgres 9.6
echo
echo "  - postgres9.6"
echo "  --------------------------------------------------------------"
docker run --name postgres9.6 -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 postgres:9.6-alpine

## pgAdmin III
echo
echo "Install pgadminIII"
echo "--------------------------------------------------------------"
sudo apt install -y pgadmin3 --no-install-recommends

echo
echo
echo "-------------------------------------------------------------------"
echo "SUCCESSFUL!!"
echo
echo "Important!"
echo "You need to restar the computer for some changes take effect"
