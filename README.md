# Dotfiles

![Platform](https://img.shields.io/badge/platform-macos%20%7C%20linux-blue)
![License](https://img.shields.io/badge/license-MIT-green)
[![Dorfiles](https://github.com/inean/dotfiles/actions/workflows/ci.yaml/badge.svg)](https://github.com/inean/dotfiles/actions/workflows/ci.yaml)

Personal dotfiles repository, managed and applied with [chezmoi](https://chezmoi.io/).

Roughly speaking,**chezmoi** stores the desired state of your dotfiles in the directory
`~/.local/share/chezmoi`. When you run `chezmoi apply`,**chezmoi** calculates the
desired contents for each of your dotfiles and then makes the minimum changes required
to make your dotfiles match your desired state

## What's Included?

The following tools are customized in my dotfiles:

- Shell: [zsh](https://www.zsh.org)
- Command line prompt: [starship](https://starship.rs)

## Configuration

Configure templates in this `chezmoi` repository via `~/.config/chezmoi/chezmoi.toml`. The following variables are expected:

| Key               | Description                         |
| ----------------- | ----------------------------------- |
| `git_email`       | email address for git configuration |
| `git_signing_key` | GPG key ID for signing git commits  |

## Installation

Install the correct binary for your operating system and architecture in
`$HOME/.local./bin` with a single command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

After `chezmoi` is installed, depoly dotfiles with:
```sh
chezmoi init inean
````

Personal secrets are stored with [gopass](https://www.gopass.pw/) and you\'ll
need the gopass CLI(`gopass`).

## Usage

Check what changes that `chezmoi` will make to your `$HOME` directory by running:

```sh
chezmoi diff
```

If you are happy with the changes that `chezmoi` will make, then run:

```sh
chezmoi apply -v
```

On any machine, you can pull and apply the latest changes from your repo with:

```sh
chezmoi update -v
```
See the [chezmoi docs](https://chezmoi.io/docs/reference/#update) for more

### Add a new file

to add a new file with `chezmoi` use the `add` command:

```sh
chezmoi add ~/.bashrc
```

Pass `--template` arg to create a template file:

```sh
chezmoi add ~/.bashrc --template
```

This will copy `~/.bashrc` to `~/.local/share/chezmoi/dot_bashrc`. See the [chezmoi
docs](https://chezmoi.io/docs/reference/#add) for more

### Edit files

You can edit files with `chezmoi` passing de `edit` command:

```sh
chezmoi edit ~/.bashrc
```

This will open `~/.local/share/chezmoi/dot_bashrc` in your `$EDITOR`. Make some changes
and save the file. When you run `chezmoi apply` the changes will be applied to your
`~/.bashrc`. See the [chezmoi docs](https://chezmoi.io/docs/reference/#edit) for more

### Merge files

If you are not happy with the changes, you can invoke a *merge tool* to merge changes
between the current contents of the file, the file in your working copy, and the
computed contents of the file:

```sh
chezmoi merge $FILE
```
