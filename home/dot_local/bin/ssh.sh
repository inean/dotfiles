#!/bin/sh

# This script generates a new SSH key for GitHub and adds it to the ssh-agent. A email address is required as an argument.
if [ $# -ne 1 ]; then
    echo "usage: $0 <email>"
    exit 1
fi
if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
    echo "SSH key already exists"
    exit 1
fi
echo "Generating a new SSH key for GitHub..."

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
ssh-keygen -t ed25519 -C "$1" -f "$HOME/.ssh/id_ed25519"

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

cat > "$HOME/.ssh/config" << EOF
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile "~/.ssh/id_ed25519"
EOF
ssh-add -K "$HOME/.ssh/id_ed25519"

# Adding your SSH key to your GitHub account
# https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
echo "run 'pbcopy < $HOME/.ssh/id_ed25519.pub' and paste that into GitHub"