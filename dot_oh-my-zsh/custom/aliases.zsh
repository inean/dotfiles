# CUSTOM ALIASES FOR ZSH
#
# Add these lines to ~/.zshrc:
# source $HOME/.oh-my-zsh/custom/aliases.zsh

# zshrc
alias zs="source ~/.zshrc"
alias zc="code ~/.zshrc"
alias za="code ~/.oh-my-zsh/custom/aliases.zsh"

# Chezmoi
alias config="chezmoi"

# Shortcuts
alias c="code"
alias p="docker"
alias P="cd ~/Projects"
alias d="cd ~/Downloads"
alias g="git"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
