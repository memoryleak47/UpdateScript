#!/bin/bash

function _install()
{
	echo -e "\nInstalling $1..."
	sudo apt-get install "$1"
}

function _build()
{
	echo -e "\nInstalling $1..."
	if [ "$(dpkg -l | grep "$1")" ]; then
		if [ "$(dpkg --status $1 | grep "^Status: install ok installed$")" ]; then
			sudo apt-get upgrade $1
		fi
	else
		sudo add-apt-repository -y $2
		sudo apt-get update
		sudo apt-get install $1
	fi
}

function _mkdir()
{
	if [ ! -d "$1" ]; then
		mkdir "$1"
	fi
}

_install git
_install vim
_install tree
_install wireshark
_install nmap
_install terminator
_install zenmap
_install curl
_install wget
# _install python3-tk
_install libsfml-dev
# _install libxtst-dev

_build telegram ppa:atareao/telegram
_build tor-browser ppa:webupd8team/tor-browser

echo -e "\nSetting up launcher..."
dconf write '/org/compiz/profiles/unity/plugins/unityshell/icon-size' '24'
dconf write '/com/canonical/unity/launcher/favorites' "['application://org.gnome.Nautilus.desktop', 'application://terminator.desktop', 'application://firefox.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

echo -e "\nSetting up Workspaces"
dconf write '/org/compiz/profiles/unity/plugins/core/hsize' '2'
dconf write '/org/compiz/profiles/unity/plugins/core/vsize' '2'

dconf write '/org/gnome/desktop/wm/keybindings/switch-to-workspace-left' "['<Control><Alt>H']"
dconf write '/org/gnome/desktop/wm/keybindings/switch-to-workspace-down' "['<Control><Alt>J']"
dconf write '/org/gnome/desktop/wm/keybindings/switch-to-workspace-right' "['<Control><Alt>L']"
dconf write '/org/gnome/desktop/wm/keybindings/switch-to-workspace-up' "['<Control><Alt>K']"

dconf write '/org/gnome/desktop/wm/keybindings/move-to-workspace-left' "['<Control><Shift><Alt>H']"
dconf write '/org/gnome/desktop/wm/keybindings/move-to-workspace-down' "['<Control><Shift><Alt>J']"
dconf write '/org/gnome/desktop/wm/keybindings/move-to-workspace-right' "['<Control><Shift><Alt>L']"
dconf write '/org/gnome/desktop/wm/keybindings/move-to-workspace-up' "['<Control><Shift><Alt>K']"

dconf write '/org/gnome/settings-daemon/plugins/media-keys/screensaver' "'disabled'" # Also used <Control><Alt>L

echo -e "\nSetting up file system"
_mkdir "$HOME/projects"
_mkdir "$HOME/projects/mind"
_mkdir "$HOME/projects/other"
_mkdir "$HOME/projects/app"
_mkdir "$HOME/projects/util"
_mkdir "$HOME/projects/game"
_mkdir "$HOME/projects/learn"

_mkdir "$HOME/apps"

echo -e "\nLoading Firefox Plugins... TODO"
echo -e "Setting up Terminal Profiles... TODO"
