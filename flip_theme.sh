#!/bin/bash
theme=$1
if [ $theme -eq 0 ]
then
   echo 'dark mode!'
   cp .emacs.dark .emacs
   cp .utoprc.dark .utoprc
   cp .config/alacritty/alacritty.yml.dark .config/alacritty/alacritty.yml
else
   echo 'light mode!'
   cp .emacs.light .emacs
   cp .utoprc.light .utoprc
   cp .config/alacritty/alacritty.yml.light .config/alacritty/alacritty.yml
fi
