#
# Vim configuration module for zsh.
#

# Abort if requirements are not met.
if (( ! $+commands[vim] )); then
  return 1
fi

# XDG path for the Vim data directory.
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
