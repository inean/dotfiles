#
# Zim configuration module for zsh
# https://zimfw.sh
#

# Module configuration
# ====================

# Git
# ---

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'G'

# input
# -----

# Append \`../\` to your input for each \`.\` you type after an initial \`..\`
zstyle ':zim:input' double-dot-expand yes

# Completion
# ----------

# Move dump files to zcache directory
zstyle ':zim:completion' dumpfile "${ZCACHEDIR}/zcompdump"
zstyle ':completion::complete:*' cache-path "$ZCACHEDIR/zcompcache"

# zsh-history-substring-search
# ----------------------------

HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS=l

# zsh-autosuggestions
# -------------------

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Find suggestions from the history only
ZSH_AUTOSUGGEST_STRATEGY=(history)
# Disable suggestions for large buffers
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# zsh-you-should-use
# ------------------

export YSU_MODE=ALL

# Initialize Zim
# ==============

export ZIM_HOME=${ZDATADIR}/zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# Post-init module configuration
# ==============================

# zsh-history-substring-search
# ----------------------------
