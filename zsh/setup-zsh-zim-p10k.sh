#!/bin/bash
#========================================================================
# Script name    :setup-zsh-zim-p10k.sh
# Description    :This script is for install ZSH+ZIM+powerlevel10k. Requires `apt`, `curl` and `git`.
# Author         :Eduardo Betanzos Morales
# Email          :ebetanzos@hotmail.es
#
# Usage:         sudo sh -c "$(curl -sSL https://raw.githubusercontent.com/betanzos/my-scripts/master/zsh/setup-zsh-zim-p10k.sh)"
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

install_all() {
	# Install ZSH
	echo "Install ZSH"
	echo "--------------------------------------------------------------"
	apt install zsh -y
	echo
	echo "ZSH has been installed!"
	echo "Remember make it the default shell using the following command 'chsh -s $(which zsh)'"

	# Install ZIM
	echo
	echo
	echo "Install ZIM"
	echo "--------------------------------------------------------------"
	curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
	chmod 777 -R .zim
	chmod 777 .z*

	# Install powerlevel10k ZSH theme in ZIM
	echo
	echo
	echo "Install theme powerlevel10k in ZIM"
	echo "--------------------------------------------------------------"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.zim/modules/powerlevel10k
	echo "zmodule powerlevel10k" >> .zimrc
	zimfw install
	curl https://raw.githubusercontent.com/betanzos/my-scripts/master/zsh/.p10k.zsh -o $HOME/.p10k.zsh 
	echo "" >> .zshrc
	echo "# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh." >> .zshrc
	echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> .zshrc
	echo
	echo "powerlevel10k theme has been installed in ZIM!"
	echo "Remember to install the fonts recommended by the author 'MesloLGS NF'"
	echo
	echo "--------------------------------------------------------------"
	echo "FINISHED!"
	echo "--------------------------------------------------------------"
}

main() {
	command -v apt >/dev/null 2>&1 || { echo '`apt` command not found. Aborting.'; exit 1; }
	command -v curl >/dev/null 2>&1 || { echo '`curl` command not found. Aborting.'; exit 1; }
	command -v git >/dev/null 2>&1 || { echo '`git` command not found. Aborting.'; exit 1; }

	install_all
}

main