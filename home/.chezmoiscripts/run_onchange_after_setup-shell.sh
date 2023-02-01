#!/bin/bash
# vim: filetype=bash
#
# Setup a POSIX-based system
#
{{ if eq .chezmoi.os "linux" "darwin" -}}
{{ include ".helpers/common.sh" }}

# ======
# MAIN
# ======
msg "After: Setting up shell"

cur_shell=$(cat /etc/passwd | grep $USER | awk -F ":" '{print $NF}')
tar_shell=$(is_callable zsh && echo zsh || echo bash)
if [ ! -x "${cur_shell}" ] || [[ ${cur_shell} != *"${tar_shell}"* ]]; then
    step "Changing the login shell to ${tar_shell}..."
    sudo chsh $USER --shell="$(which ${tar_shell})"
fi

if ! is_callable xsh && [ -r ~/.config/xsh/xsh.sh ]; then
    step "Bootstrapping xsh..."
    source ~/.config/xsh/xsh.sh
    xsh bootstrap --shells posix:bash:zsh
fi

trap bye EXIT

{{ end -}}
