
## Pome.
### Details
This repo contains all my important system configuration files, mainly as a backup but also for anyone who wants to steal my configs.
It contains files corresponding to my rice which I call "pome", made on the 2 border window manager ([2bwm](https://github.com/venam/2bwm)). Simple, calm and comfy.
My build of 2bwm (the one in the screenshots), can be found over [here](https://github.com/savar95x/2bwm).
### Preview
<img src=.assets/pome/new3.png />
<img src=.assets/pome/new4.png />
<img src=.assets/pome/new2.png />
Don't mind the bar, this is an old screenshot
<img src=.assets/pome/new1.png />
<img src=.assets/pome/old.png />

<!--My rice on 2bwm using gruvbox. Simple, calm and comfy. I call it "pome".-->

ps:
if you're looking for configs of my older rices (endless on dwm, dkwm), they'd be available in my [junkyard](https://github.com/savar95x/junkyard).

### Default Keybindings

These are the basic keybindings. Read through the `config.h` in my `2bwm` repo for more shortcuts.

|        Keybind            |                 Function                   |
| ------------------------- | ------------------------------------------ |
| `MOD + Enter`             | Launch terminal (alacritty)                |
| `MOD + Q`                 | Close window                               |
| `MOD + {H,J,K,L}`         | Move the window to {Left, Down, Up, Right} |
| `MOD + Shift + {H,J,K,L}` | Resize the window                          |
| `MOD + X`                 | Maximize a window                          |
| `MOD + Shift + X`         | Fullscreen a window                        |
| `MOD + P`                 | Open app launcher                          |
| `MOD + Shift + BackSpace` | Open powermenu                             |
| `MOD + R`                 | Open lf (terminal file manager)            |
| `MOD + A`                 | Makes the active window unkillable         |
| `MOD + F`                 | Makes the active window focused            |

Note: `MOD` is the windows key

## Installation

#### NOTE: This highly experimental, proceed at your own risk

You could just copy paste the .config and .local directories manually, but I recommend, and personally use, gnu stow.<br>
If you choose to use gnu stow, clone the repo at a neat place, for example, ~/.local/repos/

### Programs
```bash
startx xwallpaper xset xsetroot xrdb setkbmap pipewire wireplumber mpd ncmpcpp picom xbanish redshift polybar rofi firefox 
```
also, all the x11 depedencies, and the ones required for compiling st and 2bwm, that you'll have to figure out yourself from the error messages, as it is distro dependent

### Manual
This will store everything in $HOME/.local/repos/

- Making that direcotory
```bash
mkdir -p $HOME/.local/repos/savar95x
```

- Installing 2bwm
```bash
cd $HOME/.local/repos/savar95x
git clone https://github.com/savar95x/2bwm.git
cd 2bwm/
make
sudo make install
```

- Installing st
```bash
cd $HOME/.local/repos/savar95x
git clone https://github.com/savar95x/st.git
cd st/
make
sudo make install
```

- Backing up ~/.config and copying my dotfiles instead
```bash
cd $HOME/.local/repos/savar95x
git clone https://github.com/savar95x/dotfiles.git
cd dotfiles/
mv $HOME/.config $HOME/.config.bak # backing up
stow -t $HOME */ # symlink the configs to $HOME/.config/
```

- Also, you should link the `~/.config/zsh/rc`, `~/.config/zsh/profile` and `~/.config/x11/init2bwm` to home as:
```bash
ln -s $HOME/.config/zsh/rc $HOME/.zshrc
ln -s $HOME/.config/x11/init2bwm $HOME/.xinitrc
ln -s $HOME/.config/zsh/profile $HOME/.zprofile
```

<br>Now your setup should more or less work, once you type startx (or startx2bwm) from the linux console. If it does not, please raise an issue.

### TODO
write an install script

### Thanks
- voldemort(pentest2k) from discord or [KT-Chovy](https://reddit.com/u/KT-Chovy) for bearing every small improvement I made with the rice
- [Elkowar](https://github.com/elkowar/) for making me believe gruvebox can be aesthetic as well
- [adi1090x](https://github.com/adi1090x/) for his rofi configs
