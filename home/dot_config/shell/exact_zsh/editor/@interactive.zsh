#
# Editor configuration module for zsh.
#

# Editor
# ======
export EDITOR='vim'
# Define the default editor.
if (( $+commands[code] )); then
  export EDITOR='code'
  alias code="code --user-data-dir='${XDG_CONFIG_HOME}/vscode' --extensions-dir='${XDG_CACHE_HOME}/vscode'"
fi
export GIT_EDITOR="$EDITOR"
export USE_EDITOR="$EDITOR"

# Convenience aliases.
alias edit='${(z)VISUAL:-${(z)EDITOR}}'
alias c='edit'
