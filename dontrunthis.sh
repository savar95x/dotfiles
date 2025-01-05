#!/bin/sh
# 
# xrdb, xwallpaper, xset, xsetroot, xbanish, picom, setxkbmap, redshift
# polybar, firefox, newsboat, lf, mpd, ncmpcpp, rofi, dunst
# st, 2bwm, dmenu
#
# custom to my liking, forced symlinking

dir=~/.local/repos/savar95x

dependencies() {
	paru -S zsh zsh-syntax-highlighting neovim lf bat xorg-server xauth xorg-xinit openbox obconf lxappearance ueberzug rofi firefox nsxiv sioyek mpv mpd ncmpcpp transimission tremc-git gucharmap polybar plank xorg-xset xorg-xrdb xorg-xetroot xorg-setxkbmap xclip maim slop redshift dunst libnotify imagemagick xcolor xdo xdotool wmctrl light pamixer pulsemixer stow ffmpeg ffmpegthumbnailer cronie
}

buildst() {
	cd $dir
	# st
	git clone https://github.com/savar95x/st
	cd st
	./compilest
	cd ..
}
buildcpufrq() {
	# auto-cpufreq
	cd $dir
	git clone https://github.com/AdnanHodzic/auto-cpufreq
	cd auto-cpufreq
	sudo ./auto-cpufreq-installer
	cd ..
}
installytdlp() {
	# yt-dlp bin
	curl -LO "https://github.com/yt-dlp/yt-dlp/releases/download/2024.12.23/yt-dlp"
	chmod +x ./yt-dlp
	mv yt-dlp ~/.local/bin/
}
installgotop() {
	# gotop bin
	curl -LO https://github.com/cjbassi/gotop/releases/download/3.0.0/gotop_3.0.0_linux_amd64.tgz
	tar xvf gotop_3.0.0_linux_amd64.tgz
	chmod +x ./gotop
	mv gotop ~/.local/bin/
	rm gotop_3.0.0_linux_amd64.tgz
}
installspotdl() {
	# spotdl in a venv
	mkdir -p ~/.local/venv
	python -m venv ~/.local/venv
	~/.local/venv/bin/python -m pip install --upgrade pip
	~/.local/venv/bin/pip install spotdl
}

create() {
	mkdir -p ~/.local/bin
	mkdir -p ~/.local/scripts
	mkdir -p ~/.local/share
	mkdir -p ~/.local/share/spotdl
	mkdir -p ~/.local/share/music/lyrics
	mkdir -p ~/.local/share/music/playlists
	mkdir -p ~/.local/share/icons
	mkdir -p ~/.local/share/font
	mkdir -p ~/.local/share/themes
	mkdir -p ~/.local/run
	mkdir -p ~/.local/run/x11
	mkdir -p ~/.local/run/pipewire
}

linkandback() {
	cd $dir/dotfiles
	./install.sh
}

symlinking() {
	ln -s ~/.config/zsh/rc ~/.zshrc
	ln -s ~/.config/zsh/profile ~/.zprofile
	ln -s ~/.local/share/themes ~/.themes
	ln -s ~/.local/share/icons ~/.icons
}

echo still in works
