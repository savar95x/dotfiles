## Pome.
### Details
My rice on [berry](https://berrywm.org) using gruvbox material. Simple, calm and comfy. I call it "pome". This is my daily driver.  
Earlier, I had it made on [2bwm](), but berry is more versatile and more power efficient. For anyone who wants to use the 2bwm version, the [config]() and [repo]() are still there.  
### Preview
#### berry
<img src=.assets/pome/newroice1.png />
<img src=.assets/pome/newroice2.png />
<img src=.assets/pome/newroice3.png />
<img src=.assets/pome/newroice4.png />

#### 2bwm

<img src=.assets/pome/new3.png />
<img src=.assets/pome/new4.png />
<img src=.assets/pome/new2.png />
Don't mind the bar, this is an old screenshot
<img src=.assets/pome/new1.png />
<img src=.assets/pome/old.png />

ps:
if you're looking for configs of my older rices (endless on dwm, dkwm), they'd be available in my [junkyard](https://github.com/savar95x/junkyard) and [dwm](https://github.com/savar95x/dwm) repo.

### Default Keybindings

These are the basic keybindings. Read through the ~~`config.h` in my `2bwm` repo~~ ~/.config/berry/sxhkdrc for more shortcuts.

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

NOTE: The install script is still in works, I recommend the manual way, but there's no guarantee it'll work. You'll have to figure out stuff for yourself (for now).  

### Programs
#### pacman (or any other)
```bash
zsh lf startx sxhkd wmctrl xdo xdotool xwallpaper xset xsetroot xrdb setkbmap pipewire wireplumber mpd dunst ncmpcpp picom xbanish redshift polybar rofi brave-bin mpv
```
#### make
```bash
berry st
```
Also, all the x11 depedencies, and the ones required for compiling st and 2bwm, that you'll have to figure out yourself from the error messages, as it is distro dependent

### Manual
This will store everything in $HOME/.local/repos/savar95x
I use `stow` to manage dotfiles, so install it from your package manager.  

- Making that directory
```bash
mkdir -p $HOME/.local/repos/savar95x
```

- Installing st
```bash
cd $HOME/.local/repos/savar95x
git clone https://github.com/savar95x/st.git
cd st/
make
sudo make install
```

- Backing up ~/.config and symlinking my dotfiles instead. Make sure you're in the `dotfiles` directory.  
```bash
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
}

create() {
	mkdir -p ~/.config
	mkdir -p ~/.local/run
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

Make sure all your drivers specific to your hardware are installed.   
Now your setup should more or less work, once you type startx (or startx2bwm) from the linux console, or just login to tty1. If it does not, please raise an issue.

#### More Dependencies
For my scripts to work properly, you'll be needing the following programs:
```bash
ImageMagick xcolor simple-mtpfs xsecurelock xdotool scrot
```
Raise an issue if something doesn't work.  

### TODO
- Write an install script.

### Thanks
- voldemort(pentest2k) from discord or [KT-Chovy](https://reddit.com/u/KT-Chovy) for bearing every small improvement I made with the rice
- [Elkowar](https://github.com/elkowar/) for making me believe gruvbox can be aesthetic as well
- [adi1090x](https://github.com/adi1090x/) for his rofi configs
