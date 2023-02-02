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
PKGS[bat]='A better cat(1);https://github.com/sharkdp/bat;0;bat'
PKGS[cloc]='Count lines of code;http://cloc.sourceforge.net/;0;cloc'
PKGS[delta]='Better vim diff;https://github.com/dandavison/delta;0;delta'
PKGS[exa]='Better ls(1);https://github.com/ogham/exa;0;exa'
PKGS[fd]='Better find(1);https://github.com/sharkdp/fd;0;fd'
PKGS[fzf]='Terminal fuzzy finder;https://github.com/junegunn/fzf;0;fzf'
PKGS[jq]='Cli json processor;https://stedolan.github.io/jq/;0;jq'
PKGS[peek]='Screen recorder;https://github.com/phw/peek;2;peek'
PKGS[ripgrep]='Better grep(1);https://github.com/BurntSushi/ripgrep;0;rg'
PKGS[restic]='Remote sync tool;https://rsync.samba.org/;1;rsync'
PKGS[starship]='Cross-shell prompt;https://starship.rs/;0;starship'
PKGS[tig]='Better git log;https://github.com/jonas/tig;0;tig'
PKGS[tmux]='Terminal multiplexer;https://github.com/tmux/tmux;0;tmux'
PKGS[tree]='File tree viewer;;0;tree'
PKGS[zathura]='Terminal pdf reader;https://pwmt.org;2;zathura'
PKGS[zoxide]='A cd that learns;https://github.com/ajeetdsouza/zoxide;0;zoxide'
PKGS[zsh]='Best shell!;https://www.zsh.org/;0;zsh'
