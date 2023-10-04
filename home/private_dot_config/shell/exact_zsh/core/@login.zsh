#
# Core configuration module for zsh.
#

# Load the core posix module.
xsh load core -s posix login

#
# XDG base directory
#
# References:
# - https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# - https://wiki.archlinux.org/index.php/XDG_Base_Directory
#


# XDG paths for zsh.
export ZDATADIR=${ZDATADIR:-$XDG_DATA_HOME/zsh}
export ZCACHEDIR=${ZCACHEDIR:-$XDG_CACHE_HOME/zsh}
command mkdir -p $ZDATADIR $ZCACHEDIR $ZDORDIR

#
# Session environment
#

if (( $+commands[wine] )); then
  # Set default wine prefix.
  export WINEPREFIX='~/.local/share/wine-default'
  # Set default wine architecture.
  export WINEARCH='win32'
  # Disable prompt for wine-gecko install.
  # export WINEDLLOVERRIDES='mshtml='
  # Workaround vulkan issue with hybrid GPU setups: https://bugs.winehq.org/show_bug.cgi?id=51210
  # See also https://forum.winehq.org/viewtopic.php?f=8&t=36177
  export VK_ICD_FILENAMES='/usr/share/vulkan/icd.d/intel_icd.x86_64.json'
fi

if (( $+commands[go] )); then
  # Add installed go binaries to PATH.
  path+=($GOPATH/bin)

  # Use the module-aware mode by default.
  export GO111MODULE='on'
fi

if (( $+commands[npm] )); then
  # Add installed node binaries to PATH.
  path+=($NPM_CONFIG_PREFIX/bin)
fi

if (( $+commands[pipx] )); then
  # Add installed python applications to PATH.
  path+=($PIPX_BIN_DIR)
fi
