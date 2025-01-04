# chastity
macOS inspired openbox rice made with the gruvbox material colorscheme.  
this is my daily driver.  
&ensp;[<kbd> <br> reddit post <br> </kbd>](https://www.reddit.com/r/unixporn/comments/1hs2pm8/openbox_chastity/)&ensp;

<img align="center" width="99%%" src=.assets/chastity/show1.png />
<img align="center" width="49%" src=.assets/chastity/show2.png />
<img align="center" width="49%" src=.assets/chastity/show3.png />

# Pome.
## berry
Pome 2.0.  
my daily driver before chastity.  
[here](https://github.com/savar95x/berry)'s my build of berry.  
([reddit post](https://www.reddit.com/r/unixporn/comments/1dh09dh/berry_pome_20/))  
<img src=.assets/pome2.0/show1.png />
<!--img src=.assets/pome2.0/show2.png />
<img src=.assets/pome2.0/show3.png />
<img src=.assets/pome2.0/show4.png />
<img src=.assets/pome2.0/show5.png /-->

## 2bwm
previous to previous rice.  
2bwm is doesnt seem to be very power efficient so not recommended.  
[here](https://github.com/savar95x/2bwm)'s my build of 2bwm.  
([reddit post](https://www.reddit.com/r/unixporn/comments/16ipnru/2bwm_its_pome_again/))  
<img src=.assets/pome/new3.png />
<!--img src=.assets/pome/old.png /-->

ps:
if you're looking for configs of my older rices (endless on dwm, dkwm), they'd be available in my [junkyard](https://github.com/savar95x/junkyard) and [dwm](https://github.com/savar95x/dwm) repo.

# Installation Guide
***STILL IN WORKS***  

This assumes you already have a working distribution (like Ubuntu or a fresh (or old) Arch install).  
Although I've not checked if the configs have any clashes with user-friendly distributions like Ubuntu, they should still work more or less.  

## Software I use
I've given package names for archlinux/pacman, but you'll have to help yourself for other distributions.  
```bash
# to search software
pacman -Ss "<string you want to query>"
```

### Main Software
| Type | Software/Packages |
| --- | --- |
| terminal | st ([my build](https://github.com/savar95/st)) |
| shell | zsh, zsh-syntax-highlighting |
| editor | neovim |
| file manager | lf, bat, ueberzug (for image previews) |
| window manager | openbox, obconf, lxappearance, xorg-server, xorg-xinit |
| app launcher | rofi |
| bar and dock | polybar and plank |
| browser | firefox |
| image viewer | nsxiv ([here](https://github.com/nsxiv/nsxiv)) |
| document reader | sioyek |
| video player | mpv |
| music | mpd, ncmpcpp |
| torrent | transmission, tremc |
| font management | gucharmap |

Install with this command, replace `paru` with the AUR helper of your choice.  
```bash
paru -S zsh zsh-syntax-highlighting neovim lf bat xorg-server xauth xorg-xinit openbox obconf lxappearance ueberzug rofi firefox sioyek mpv mpd ncmpcpp transimission tremc-git gucharmap polybar plank
```
Don't forget to build *st* and *nsxiv* from the above given links.  
### Drivers and Audio
*Ignore this if you use user-friendly distros, or have a working install already*  
```bash
sudo pacman -S xf86-input-libinput xf86-video-intel mesa vulkan-intel intel-media-driver
```
```bash
sudo pacman -S pipewire wireplumber bluez bluez-utils sof-firmware
```
### For Scripts and Quality of Life
```bash
paru -S xorg-xset xorg-xrdb xorg-xetroot xclip maim slop dunst libnotify imagemagick xcolor xdo xdotool wmctrl light pamixer pulsemixer stow ffmpeg ffmpegthumbnailer
```

### More Software I use
- [autocpu-freq](https://github.com/AdnanHodzic/auto-cpufreq) (for battery efficiency, highly recommended)  
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) (to download youtube videos/playlists)  
- [spotdl](https://github.com/spotDL/spotify-downloader) (to download music)  
- [gotop](https://github.com/xxxserxxx/gotop) (sysinfo, binary from releases recommended)  
- hugo (to manage website)  
- syncthing (for file syncing with phone)  
- cronie (as the cron daemon for periodic health notifications)  
- zed (for markdown previews and playing around)  

These are good software but not necessary for my rice to work.  

## Copying/Symlinking Directories
Backup conflicting configs and use gnu stow
```bash
git clone https://github.com/savar95x/dotfiles
cd dotfiles
mkdir -p ~/.configs.bak
for conf in $(ls configs/.config); do
    [ -f ~/.config/$conf ] && mv ~/.config/$conf ~/.config.bak/$conf
done
stow -t ~/ */
```
Clone this to a directory you usually clone stuff into like ~/.local/repos/, and stow will symlink the way it does.  
Also, do this  
```bash
ln -s ~/.config/zsh/rc ~/.zshrc
ln -s ~/.config/zsh/profile ~/.zprofile
mkdir -p ~/.local/share/themes
ln -s ~/.local/share/themes ~/.themes
mkdir -p ~/.local/share/icons
ln -s ~/.local/share/icons ~/.icons
mkdir -p ~/.local/share/fonts
```

## Setup Cronjob
Install `cronie`, and enable it using  
```bash
sudo systemctl enable cronie
```
and add the following to `cronjob -e`  
```bash
* * * * * ~/.local/scripts/health
```

## Theme, Icons and Fonts
- Icon pack is [Numix circle](https://github.com/numixproject/numix-icon-theme-circle). Clone this into ~/.icons/  
- GTK theme is [Gruvbox Material](https://github.com/TheGreatMcPain/gruvbox-material-gtk). Clone this into ~/.theme/  
- Cursor is [Simp1e](https://www.gnome-look.org/p/1932768). This should also go into ~/.icons/  

Once copied, you can set these using lxappearance.  

- The fonts I use are *[Schibsted Grotesk](https://fonts.google.com/specimen/Schibsted+Grotesk)*, *[Inter](https://fonts.google.com/specimen/Inter)*, and *[Fragment Mono](https://uncut.wtf/monospace/fragment-mono/)*. Icons are from [nerd fonts symbols](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/NerdFontsSymbolsOnly.zip) and [fontawesome](https://fontawesome.com/download). Make sure their files (.ttf or .otf) are extracted (somewhere) in ~/.local/share/fonts/  

Run this once after extracting fonts  
```bash
fc-cache -fv
```

## Default Shell
```bash
chsh -s /usr/bin/zsh
```
# Launching
**NOTE**: If your system somehow manages audio, you might consider commenting the audio_server.sh command in ~/.zprofile  

To launch openbox, if you do not use a display manager (/a login manager) it should launch itself when you login from tty1 with zsh as the default shell.  
If it doesn't, something might be wrong, check if you linked .zprofile.  
You can try doing this though  
```bash
[ -f ~/.xinitrc ] && mv ~/.xinitrc ~/.config.bak/
ln -s ~/.config/x11/initopenbox ~/.xinitrc
```
Then run  
```bash
startx
```

# Keybindings

Read through ~/.config/openbox/rc.xml for more shortcuts.

| Keybind | Function |
| --- | --- |
| `MOD + Enter` | Launch terminal (st) |
| `MOD + Q` | Close window |
| `MOD + {H,J,K,L}` | Move the window to {Left, Down, Up, Right} |
| `MOD + Shift + {H,J,K,L}` | Resize the window |
| `MOD + Shift + F` | Monocle a window |
| `MOD + F` | Fullscreen a window |
| `MOD + P` | Open app launcher |
| `MOD + S` | List out the useful scripts in ~/.local/scipts/ in rofi |
| `MOD + Shift + S` | Take Screenshot (using maim and slop) |
| `MOD + R` | Open lf (terminal file manager) |

Note: `MOD` is the windows key

<!--
## Installation
I'm writing it with a fresh install of [void linux](https://voidlinux.org) in mind (even though my main device runs arch with these dots). But it is possible to follow along the intructions for any distro with slight adjustments (mainly for package names).
Also, this rice was made on a 1920x1080 monitor, so for now you'll have to edit some configs (namely berry, rofi, poybar) to fit your setup.

### Overview
I manage my dotfiles using gnu `stow`. The way I use it is that my dotfiles (this git repo) are kept in a separate directory anywhere on the system, and then I use stow to symlink them to their original rightful paths (the the weird nesting).

### Instructions
#### Internet
log in as root
```bash
vi /etc/wpa_supplicant/wpa_supplicant-1.conf
```
add the following lines
```bash
ctrl_interface=/run/wpa_supplicant
update_config=1
```
save and exit and run
```bash
wpa_passphrase MYSSID passphrase >> /etc/wpa_supplicant/wpa_supplicant-1.conf
wpa_supplicant -B -i *interface* -c /etc/wpa_supplicant/wpa_supplicant-1.conf
```
use `ip link` to identify the interface
[guide](https://wiki.archlinux.org/title/wpa_supplicant)

#### package manager
This updates the packages after first install.
```bash
xbps-install -Su
```
This installs all the needed packages.
```bash
sudo xbps-install -S stow git make neovim iwd bat pkg-config libXft-devel gcc libXinerama-devel xorg-server xf86-input-libinput xauth xclip zsh zsh-syntax-highlighting lf ueberzugpp ffmpegthumbnailer xinit sxhkd wmctrl xdo xdotool xwallpaper xset xsetroot xrdb setkbmap pipewire wireplumber mpd mpc dunst libnotify ncmpcpp picom xbanish redshift polybar rofi mpv pamixer pulsemixer
# autocpu-freq not in xbps repo
```
Installs the graphics drivers for **Intel**. If you're using something else then [see this](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html).
```bash
sudo xbps-install -S xf86-video-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel
```

#### enabling services
```bash
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/iwd /var/service/
# autocpu-freq
```

#### cloning repo
```bash
mkdir -p ~/.local/repos/savar95x
# This is where I recommend to store stuff, and where I personally keep my dots on my system.
cd ~/.local/repos/savar95x
git clone https://github.com/savar95x/dotfiles
```
This clones the dotfiles to ~/.local/repos/savar95x.

#### make
`berry` and `st`.

- Installing st
```bash
cd $HOME/.local/repos/savar95x
git clone https://github.com/savar95x/st.git
cd st/
make
sudo make install
```

- Installing berry
```bash
cd $HOME/.local/repos/savar95x
git clone https://github.com/savar95x/berry.git
cd berry/
make
sudo make install
```

#### backing up ~/.config and symlinking my dotfiles instead.
```bash
#/bin/sh
cd $HOME/.local/repos/savar95x/dotfiles
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
    mkdir -p ~/.local/share/zsh
    mkdir -p ~/.local/share/spotdl
    mkdir -p ~/.local/share/lyrics
    mkdir -p ~/.local/share/cache/lf
    mkdir -p ~/.local/share/themes
    mkdir -p ~/.local/share/icons
    mkdir -p ~/.local/run/x11
    mkdir -p ~/.local/run/pipewire
    mkdir ~/mus
    mkdir ~/dlds
    mkdir ~/dox
    mkdir ~/pix
    mkdir ~/vids
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

backup
remove
create
stow_stuff
symlinking
```

#### shell
```bash
chsh -s /usr/bin/zsh
```
[guide](https://wiki.archlinux.org/title/command-line_shell)

#### more dependencies
For my scripts to work properly, you'll be needing the following programs:
```bash
ImageMagick xcolor simple-mtpfs xsecurelock xdotool scrot
```
To start the WM, type `startx` from the command line, or just login to tty1.
Raise an issue if something doesn't work.

### TODO
- [ ] Improve install instructions
- [ ] Add fonts, simp1e-cursor, gruvbox-material-gtk (via links and downloading).
- [ ] Fix some shortcuts (like in file manager) being username dependent.
- [ ] Add quality of life stuff like syncthing, downloader-cli, sof-firmware, spotdl (via links and downloading).
- [ ] rofi -show window with hidden windows for quicknote/lofi_music to work

All the important dots should be in openbox/ and scripts/.
Note that the gruvbox directory in openbox/theme/ should go into ~/.theme for obconf to detect it.
And yeah, use obconf to apply the theme to openbox.
The fonts I use are Schibsted Grotesk, Inter, and Fragment Mono.
I'll reorganise the directory structure soon to make it more accessible.
-->
<!--
- [ ] Check out [larbs](https://larbs.xyz) to realise how he does it.
### Thanks
- voldemort(pentest2k) from discord or [KT-Chovy](https://reddit.com/u/KT-Chovy) for bearing every small improvement I made with the rice
- [Elkowar](https://github.com/elkowar/) for making me believe gruvbox can be aesthetic as well
- [adi1090x](https://github.com/adi1090x/) for his rofi configs
-->
