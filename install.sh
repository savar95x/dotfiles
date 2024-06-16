#!/bin/sh
# 
# xrdb, xwallpaper, xset, xsetroot, xbanish, picom, setxkbmap, redshift
# polybar, firefox, newsboat, lf, mpd, ncmpcpp, rofi, dunst
# st, 2bwm, dmenu
#
# custom to my liking, forced symlinking
backup() {
	[ -d ~/.config] && mv ~/.config ~/.config.bak
	[ -d ~/.local/bin] && mv ~/.local/bin ~/.local/bin.bak
	[ -d ~/.local/scripts] && mv ~/.local/scripts ~/.local/scripts.bak
}

remove() {
	[ -d ~/.config] && rm -rf ~/.config
	[ -d ~/.local/bin] && rm -rf ~/.local/bin
	[ -d ~/.local/scripts] && rm -rf ~/.local/scripts
	[ -d ~/.local/run/x11] && rm -rf ~/.local/run/x11
	[ -d ~/.local/run/pipewire] && rm -rf ~/.local/run/pipewire
	[ -d ~/.local/share/spotdl] && rm -rf ~/.local/share/spotdl
}

create() {
	mkdir -p ~/.config
	mkdir -p ~/.local/run
	mkdir -p ~/.local/share
	mkdir -p ~/.local/run/x11
	mkdir -p ~/.local/run/pipewire
}

stow_stuff() {
	stow -t ~/ */
}

symlinking() {
	ln -s ~/.config/zsh/rc ~/.zshrc
	ln -s ~/.config/zsh/profile ~/.zprofile
	ln -s ~/.local/share/themes ~/.themes
	ln -s ~/.local/share/icons ~/.icons
}

stow_stuff
