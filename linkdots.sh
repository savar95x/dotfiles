#!/bin/sh
green='\033[0;32m'
black='\033[0;30m'
clean='\033[0m'
backupdir=~/.config.bak
echo "This script will backup conflicting files in ~/.config/ to $backupdir, and symlink my configs instead.\nMake sure $backupdir doesn't exist when this script is run."
echo "Continue? (y/N)"
read ans
if [ $ans != y ] && [ $ans != Y ]; then
	echo "Exiting without doing anything" && exit
fi

# backup
[ -d $backupdir ] && echo "$backupdir already exists. Please make sure $backupdir doesn't exist.\nExiting without doing anything." && exit
mkdir -p $backupdir
echo "$backupdir created"
for conf in $(ls configs/.config); do
	([ -f ~/.config/$conf ] || [ -d ~/.config/$conf ]) &&
		mv ~/.config/$conf $backupdir/$conf && echo "moved ~/.config/$conf into $backupdir/$conf"
done

# symlink
stow -t ~/ */ && echo "symlink successful"
echo "script ending ${green}successfully${clean}!"
exit
