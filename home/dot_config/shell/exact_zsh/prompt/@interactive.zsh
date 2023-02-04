#
# starisho configuration module
#

# Abort if requirements aren't met
if ! $(command -v starship); then
    return 1
fi

# Startup zoxide
eval "$(starship init zsh)"
