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
  if [ "$(command -v xdg-settings)" ]; then
    browser="$(xdg-settings get default-web-browser)"
    export BROWSER="$browser"
  else # macOS
    # set sanity default
    export BROWSER=safari
    # get the default browser
    browser=$(defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F'"' '/http;/{print window[(NR)-1]}{window[NR]=$2}')
    # set the browser
    if [ "$browser" = "com.apple.Safari" ]; then
      export BROWSER=safari
    elif [ "$browser" = "com.apple.SafariTechnologyPreview" ]; then
      export BROWSER=safari-technology-preview
    elif [ "$browser" = "com.google.Chrome" ]; then
      export BROWSER=google-chrome
    elif [ "$browser" = "com.google.Chrome.canary" ]; then
      export BROWSER=google-chrome-canary
    elif [ "$browser" = "com.apple.WebKit.WebContent" ]; then
      export BROWSER=firefox
    fi
  fi
fi

# Editor
# ======
export EDITOR='vim'
# Define the default editor.
if [ "$(command -v code)" ]; then
  export EDITOR='code'
fi
export GIT_EDITOR="$EDITOR"
export USE_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# Pager
# =====
export PAGER='less'