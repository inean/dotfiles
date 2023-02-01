#!/bin/bash
# vim: filetype=bash
# Core packages: curl, git, node(npm), python(pip), wget

# Package list
# ==============

declare -A PKGS # PKG[name]='desc;src;cond;bin'
# name: Name of app (not package name, different for each manager)
# desc<optional>: Short description of app
# src<optional>: link to website
# cond: Determines conditions for installing or not installing
#   - 0: Always install
#   - 1: Install only on non-ephemeral devices
#   - 2: Install only on non-headless/non-ephemeral devices
# bin<optional>: binary name to check if it is already installed
PKGS[arandr]='Gui for xrandr;https://christian.amsuess.com/tools/arandr/;2;arandr'
PKGS[atool]='Archive manager;https://www.nongnu.org/atool/;0;atool'
PKGS[autorandr]='Display config manager;https://github.com/phillipberndt/autorandr;2;autorandr'
PKGS[bat]='A better cat(1);https://github.com/sharkdp/bat;0;bat'
PKGS[bitwise]='Terminal bitwise calc;https://github.com/mellowcandle/bitwise;0;bitwise'
PKGS[bottom]='A better top(1);https://github.com/ClementTsang/bottom;0;btm'
PKGS[calc]='Terminal calc;https://packages.ubuntu.com/focal/calc;0;calc'
PKGS[cheat]='Cheatsheets from terminal;https://github.com/chubin/cheat.sh;0;cht.sh'
PKGS[cloc]='Count lines of code;http://cloc.sourceforge.net/;0;cloc'
PKGS[delta]='Better vim diff;https://github.com/dandavison/delta;0;delta'
PKGS[dunst]='Better notification daemon;https://github.com/dunst-project/dunst;2;dunst'
PKGS[elinks]='Terminal web browser;http://elinks.or.cz/;0;elinks'
PKGS[exa]='Better ls(1);https://github.com/ogham/exa;0;exa'
PKGS[fd]='Better find(1);https://github.com/sharkdp/fd;0;fd'
PKGS[fzf]='Terminal fuzzy finder;https://github.com/junegunn/fzf;0;fzf'
PKGS[jq]='Cli json processor;https://stedolan.github.io/jq/;0;jq'
PKGS[htop]='Better top(1);https://htop.dev/;0;htop'
PKGS[mpv]='Command-line media player;https://mpv.io/;2;mpv'
PKGS[neovim]='Best text editor!;https://neovim.io/;0;nvim'
PKGS[nitrogen]='Wallpaper config;https://wiki.archlinux.org/index.php/nitrogen;2;nitrogen'
PKGS[papirus]='Icon theme;https://github.com/PapirusDevelopmentTeam/papirus-icon-theme;2;'
PKGS[peek]='Screen recorder;https://github.com/phw/peek;2;peek'
PKGS[redshift]='Blue light filter;http://jonls.dk/redshift/;2;redshift-gtk'
PKGS[restic]='Fast, efficient backups;https://github.com/restic/restic;1;restic'
PKGS[ripgrep]='Better grep(1);https://github.com/BurntSushi/ripgrep;0;rg'
PKGS[rofi]='Application launcher;https://github.com/davatorium/rofi;2;rofi'
PKGS[restic]='Remote sync tool;https://rsync.samba.org/;1;rsync'
PKGS[screenkey]='Show keys;https://gitlab.com/screenkey/screenkey;2;screenkey'
PKGS[scrot]='Screenshoot tool;https://github.com/dreamer/scrot;2;scrot'
PKGS[starship]='Cross-shell prompt;https://starship.rs/;0;starship'
PKGS[suckless-tools]='Tools that suck less;https://tools.suckless.org/;2;dmenu'
PKGS[sxiv]='Terminal image viewer;https://github.com/muennich/sxiv;2;sxiv'
PKGS[tig]='Better git log;https://github.com/jonas/tig;0;tig'
PKGS[tmux]='Terminal multiplexer;https://github.com/tmux/tmux;0;tmux'
PKGS[trash-cli]='Terminal trash tool;https://github.com/andreafrancia/trash-cli;0;trash'
PKGS[trayer]='System tray;https://github.com/sargon/trayer-srg;2;trayer'
PKGS[tree]='File tree viewer;;0;tree'
PKGS[xautolock]='Auto locker tool;;2;xautolock'
PKGS[xcompmgr]='X compositor;https://wiki.archlinux.org/title/xcompmgr;2;xcompmgr'
PKGS[xmobar]='X bar;https://github.com/jaor/xmobar;2;xmobar'
PKGS[xmonad]='X window manager;https://xmonad.org/;2;xmonad'
PKGS[zathura]='Terminal pdf reader;https://pwmt.org;2;zathura'
PKGS[zoxide]='A cd that learns;https://github.com/ajeetdsouza/zoxide;0;zoxide'
PKGS[zsh]='Best shell!;https://www.zsh.org/;0;zsh'
