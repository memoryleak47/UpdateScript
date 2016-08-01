#!/bin/bash

function _install()
{
	if [ $(dpgk -l | grep "$1") ]; then
		sudo apt upgrade "$1"
	else
		sudo apt install "$1"
	fi
}

function _mkdir()
{
	if [ ! -d "$1" ]; then
		mkdir "$1"
	fi
}

echo "Installing nice software..."
_install git
_install vim

echo "Setting up launcher..."
dconf write '/org/compiz/profiles/unity/plugins/unityshell/icon-size' '24'
dconf write '/com/canonical/unity/launcher/favorites' "['application://org.gnome.Nautilus.desktop', 'application://gnome-terminal.desktop', 'application://firefox.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"

echo "Setting up file system"
_mkdir "$HOME/projects"
_mkdir "$HOME/projects/mind"
_mkdir "$HOME/projects/other"
_mkdir "$HOME/projects/app"
_mkdir "$HOME/projects/util"
_mkdir "$HOME/projects/game"
_mkdir "$HOME/projects/learn"

_mkdir "$HOME/apps"

echo "Installing Telegram..."
# TODO

echo "Installing Tor..."
# TODO

echo "Loading Firefox Plugins..."
