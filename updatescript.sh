#!/bin/bash

function _install()
{
	echo -e "\nInstalling $1..."
	if [ "$(dpkg -l "$1")" ]; then
		if [ "$(apt list --upgradeable | grep $1)" ]; then
			sudo apt upgrade "$1"
		fi
	else
		sudo apt install "$1"
	fi
}

function _build()
{
	echo -e "\nInstalling $1..."
	if [ "$(dpkg -l | grep "$1")" ]; then
		if [ "$(apt list --upgradeable | grep $1)" ]; then
			sudo apt-get upgrade $1
		fi
	else
		sudo add-apt-repository -y $2
		sudo apt-get update
		sudo apt-get install telegram
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

_build telegram ppa:atareao/telegram
_build tor-browser ppa:webupd8team/tor-browser

echo -e "\nSetting up launcher..."
dconf write '/org/compiz/profiles/unity/plugins/unityshell/icon-size' '24'
dconf write '/com/canonical/unity/launcher/favorites' "['application://org.gnome.Nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

echo -e "\nSetting up Workspaces"
dconf write '/org/compiz/profiles/unity/plugins/core/hsize' '2'
dconf write '/org/compiz/profiles/unity/plugins/core/vsize' '2'

echo -e "\nSetting up file system"
_mkdir "$HOME/projects"
_mkdir "$HOME/projects/mind"
_mkdir "$HOME/projects/other"
_mkdir "$HOME/projects/app"
_mkdir "$HOME/projects/util"
_mkdir "$HOME/projects/game"
_mkdir "$HOME/projects/learn"

_mkdir "$HOME/apps"


echo -e "\nLoading Firefox Plugins..."
