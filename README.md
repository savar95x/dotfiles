## Pome.
### Details
My rice on [berry](https://berrywm.org) using gruvbox material. Simple, calm and comfy. I call it "pome". This is my daily driver.  
Earlier, I had it made on [2bwm](), but berry is more versatile and more power efficient. For anyone who wants to use the 2bwm version, the [config]() and [repo]() are still there.  
### Preview
#### berry
[here](https://github.com/savar95x/berry)'s my build of berry.  
<img src=.assets/pome2.0/show1.png />
<img src=.assets/pome2.0/show2.png />
<img src=.assets/pome2.0/show3.png />
<img src=.assets/pome2.0/show4.png />
<img src=.assets/pome2.0/show5.png />

#### 2bwm
[here](https://github.com/savar95x/2bwm)'s my build of 2bwm.  
<img src=.assets/pome/new3.png />
<img src=.assets/pome/old.png />

ps:
if you're looking for configs of my older rices (endless on dwm, dkwm), they'd be available in my [junkyard](https://github.com/savar95x/junkyard) and [dwm](https://github.com/savar95x/dwm) repo.

### Default Keybindings

These are the basic keybindings. Read through the ~/.config/berry/sxhkdrc for more shortcuts.

|        Keybind                    |                 Function                                     |
| --------------------------------- | ------------------------------------------------------------ |
| `MOD + Enter`                     | Launch terminal (st)                                  |
| `MOD + Q`                         | Close window                                                 |
| `MOD + {H,J,K,L}`                 | Move the window to {Left, Down, Up, Right}                   |
| `MOD + Shift + {H,J,K,L}`         | Resize the window                                            |
| `MOD + Shift + F`                 | Monocle a window                                            |
| `MOD + F`                         | Fullscreen a window                                          |
| `MOD + P`                         | Open app launcher                                            |
| `MOD + S`                         | List out the useful scripts in ~/.local/scipts/ in rofi      |
| `MOD + Shift + BackSpace`         | Open powermenu                                               |
| `MOD + R`                         | Open lf (terminal file manager)                              |

Note: `MOD` is the windows key

## Installation

The installation instructions are currently in works.  
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
- [x] fix spotdl directory
- [ ] better / more sensible keybindings
- [ ] improve zsh vi mode cursor
- [ ] Add fonts, simp1e-cursor, gruvbox-material-gtk (via links and downloading).
- [ ] Fix some shortcuts (like in file manager) being username dependent.  
- [ ] Add quality of life stuff like syncthing, downloader-cli, sof-firmware, spotdl (via links and downloading).
- [ ] Port configs to 1366x768 as well. Maybe learn to use VM.
- [ ] Check out [larbs](https://larbs.xyz) to realise how he does it.
- [ ] Write an install script.

<!--
### Thanks
- voldemort(pentest2k) from discord or [KT-Chovy](https://reddit.com/u/KT-Chovy) for bearing every small improvement I made with the rice
- [Elkowar](https://github.com/elkowar/) for making me believe gruvbox can be aesthetic as well
- [adi1090x](https://github.com/adi1090x/) for his rofi configs
-->
