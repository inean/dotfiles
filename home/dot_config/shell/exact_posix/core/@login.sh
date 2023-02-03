#
# Core configuration module
#

# XDG Base dir
# ==============
# References:
# - https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# - https://wiki.archlinux.org/index.php/XDG_Base_Directory

#
# Paths
# =======

# Prepend user binaries to PATH to allow overriding system commands.
path_prepend "${XDG_BIN_HOME}" PATH
path_prepend "${CARGO_HOME}/bin" PATH

# Browser
# =======
export BROWSER=elinks
# Define the default web browser.
if [ -n "$DISPLAY" ]; then
  export BROWSER=firefox
fi

# Editor
# ======
export EDITOR='vim'
# Define the default editor.
if is_callable code; then
  export EDITOR='code'
fi
export GIT_EDITOR="$EDITOR"
export USE_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# Pager
# =====
export PAGER='less'