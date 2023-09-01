## My dotfiles
My rice on 2bwm using gruvbox. Simple, calm and comfy. I call it "pome".

ps:
if you're looking for configs of my older rices (endless on dwm, dkwm), they'd be available in my [junkyard](https://github.com/savar95x/junkyard).

## Installation
You could just copy paste the .config and .local directories, but I recommend, and personally use, gnu stow.<br>
If you choose to use gnu stow, clone the repo at a neat place, for example, ~/.local/repos/

### Manual

```bash
# installing 2bwm
git clone https://github.com/savar95x/2bwm.git
cd ./2bwm
make
sudo make install
cd ../
# placing configuration files
git clone https://github.com/savar95x/dotfiles.git
cd ./dotfiles
mv $HOME/.config $HOME/.config.bak # backing up
stow -t $HOME pome/ # symlink the configs to $HOME/.config/
```

## Preview
<img src=.assets/pome.png />

### TODO
write an install script<br>
replace directory-rices with branches
