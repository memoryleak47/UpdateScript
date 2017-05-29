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

if [ "a$1" != "ano-config" ]; then
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

	mkdir ~/.config/terminator &>/dev/null

	echo "Configuring Terminator..."
	echo '''
[global_config]
[keybindings]
  broadcast_all = None
  broadcast_group = None
  broadcast_off = None
  close_term = <Primary>q
  close_window = <Primary>w
  copy = <Primary><Shift>c
  cycle_next = None
  cycle_prev = None
  edit_tab_title = None
  edit_terminal_title = None
  edit_window_title = None
  go_down = <Primary>j
  go_left = <Primary>h
  go_next = None
  go_prev = None
  go_right = <Primary>l
  go_up = <Primary>k
  group_all = None
  group_all_toggle = None
  group_tab = None
  group_tab_toggle = None
  help = None
  hide_window = None
  insert_number = None
  insert_padded = None
  layout_launcher = None
  line_down = None
  line_up = None
  move_tab_left = None
  move_tab_right = None
  new_tab = None
  new_terminator = None
  new_window = None
  next_profile = None
  next_tab = None
  prev_tab = None
  previous_profile = None
  resize_down = <Alt>j
  resize_left = <Alt>h
  resize_right = <Alt>l
  resize_up = <Alt>k
  rotate_ccw = None
  rotate_cw = None
  scaled_zoom = None
  search = None
  split_horiz = <Shift><Alt>j
  split_vert = <Shift><Alt>h
  toggle_scrollbar = None
  toggle_zoom = None
  ungroup_all = None
  ungroup_tab = None
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    cursor_color = "#aaaaaa"
''' > ~/.config/terminator/config

fi
