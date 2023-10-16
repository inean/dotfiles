#
# Editor configuration module for zsh.
#

# Editor
# ======
export EDITOR='vim'
export GIT_EDITOR="$EDITOR"

# Define the default editor.
if (( $+commands[code] )); then
  export EDITOR='code'
  export GIT_EDITOR="$EDITOR -w"
fi

# Convenience aliases.
alias edit='${(z)VISUAL:-${(z)EDITOR}}'
alias c='edit'
