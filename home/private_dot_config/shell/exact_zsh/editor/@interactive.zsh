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
  alias code="code --user-data-dir='${XDG_CONFIG_HOME}/vscode' --extensions-dir='${XDG_CACHE_HOME}/vscode'"
fi

# Convenience aliases.
alias edit='${(z)VISUAL:-${(z)EDITOR}}'
alias c='edit'
