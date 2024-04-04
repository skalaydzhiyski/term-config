#!/bin/bash
theme=$1
if [ $theme -eq 0 ]
then
   echo 'dark mode!'
   cp .emacs.dark .emacs
   cp .utoprc.dark .utoprc
   cp .config/alacritty/alacritty.toml.dark .config/alacritty/alacritty.toml
else
   echo 'light mode!'
   cp .emacs.light .emacs
   cp .utoprc.light .utoprc
   cp .config/alacritty/alacritty.toml.light .config/alacritty/alacritty.toml
fi
