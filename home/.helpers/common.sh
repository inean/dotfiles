#!/bin/bash
# vim: filetype=bash

# Globals
# =========
BASH_COMP_DIR="/etc/bash_completion.d"
ZSH_COMP_DIR="/usr/local/share/zsh/site-functions"

# Msg helpers
# =============
# Standardize messages for all user visible scripts

# Color helpers
cn=$'\e[0m'; black=$'\e[1;30m'; red=$'\e[1;31m'; green=$'\e[1;32m'
yellow=$'\e[1;33m'; blue=$'\e[1;34m'; magenta=$'\e[1;35m'; cyan=$'\e[1;36m'
white=$'\e[1;37m'

msg()
{
    echo ""
    echo "${cyan}--------------------------------------------------${cn}"
    echo "${cyan}-->${white} ${1} ${cn}"
    echo ""
}
bye()
{
    echo ""
    echo "${cyan}-->${white} End of $0 ${cn}"
    echo "${cyan}--------------------------------------------------${cn}"
}
step() { echo -e "${green} :: ${cn}${1}"; }
note() { echo -e "    ${1}"; }
err() {  echo -e "    ${red}ERROR${cn}: ${1}"; }

# Functions
# ===========

# Prompt user input
# @param msg: question to user
# @return 0 if they respoded 'y' or 'Y'
prompt_yes()
{
    msg=${1}
    read -p "${1}" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 1
    fi
    return 0
}

# Determine if string is denotes true ([yY], [yY]es, true)
# @param {1}: the string
# @return 0 if true
is_true() {
    if [[ "${1,,}" =~ ^[Yy]$ ]] \
        || [[ "${1,,}" =~ ^[Yy]es$ ]] \
        || [[ "${1,,}" =~ "true" ]]; then
        return 0
    fi
    return 1
}

# Determine if file or command is callable
# @param vararg: list of commands/files
# @return 0 if true
is_callable()
{
    for cmd in "$@"; do
        command -v "$cmd" >/dev/null || return 1
    done
}

# From a well formatted version string, determine if it is at least a given version
# @param ver: version string
# @param minver: minimum version string
# @return 0 if true
is_atleast()
{
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

# Determine the latest release version of a github repo
# @param repo: repo shortname (<user>/<repo-name>)
# @param prefix: prefix of the version names (sometimes it starts with "v")
# @return outputs latest version name or returns 1
get_latest_github()
{
    repo="${1}"
    prefix="${2}"
    ver=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | \
        grep -Po '"tag_name": "'${prefix}'\K[0-9.]+')
    if [ -z "$ver" ]; then
        return 1
    fi
    echo "$ver"
}

# Install packages from the package list
# Helper script that maintains a list of packages for install on any machine
# but allows the caller to define how each package is installed (often dependent
# on the distro). Source this script and define the functions to install each
# package as "PKGS.<pkg_name>", then call "install_pkgs <headless> <eph>"
# @param pkgslist: array of package definitions
# @param headless: 'yes' if headless
# @param ephemeral: 'yes' if ephemeral
install_pkgs()
{
    local -n pkgslist=${1}
    headless="${2}"
    ephemeral="${3}"
    # Determine which packages can be installed
    for name in "${!pkgslist[@]}"; do
        IFS=";" read -r -a arr <<< "${pkgslist[$name]}"
        desc=${arr[0]}; src=${arr[1]}; cond=${arr[2]}; bin=${arr[3]};
        # Check if we should not install
        if ([ ${cond} = "1" ] && is_true ${ephemeral}) ||
            ([ ${cond} = "2" ] && (is_true ${headless} || is_true ${ephemeral})); then
            continue
        elif is_callable ${bin}; then
            step "Already installed ${green}${name}${cn}, skipping..."
            continue
        else
            func="PKGS.${name}"
            step "Installing ${green}${name}${cn}..."
            if [[ $(type -t $func) != function ]]; then
                err "No installer found for '${name}' (expected: ${func})"
            else
                $func
            fi
        fi
    done
}
