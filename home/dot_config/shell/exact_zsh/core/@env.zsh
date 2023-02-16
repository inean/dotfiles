# Disable control flow (^S/^Q) even for non-interactive shells.
# This is useful with e.g. `tmux new-session -s foo vim`
setopt no_flow_control
#
# Core configuration module for zsh.
#

# Ensure that path arrays do not contain duplicates.
typeset -gU i			\
  CDPATH cdpath 		\
  FPATH fpath 			\
  MANPATH manpath 		\
  MODULE_PATH module_path 	\
  MAILPATH mailpath 		\
  PATH path

# Disable control flow (^S/^Q) even for non-interactive shells.
# This is useful with e.g. `tmux new-session -s foo vim`
setopt no_flow_control

# load posix @env 
xsh load core -s posix

