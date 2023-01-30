# Dotfiles

![Platform](https://img.shields.io/badge/platform-macos%20%7C%20linux-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Personal dotfiles repository, managed with [chezmoi](https://chezmoi.io/).

Roughly speaking,**chezmoi** stores the desired state of your dotfiles in the directory
`~/.local/share/chezmoi`. When you run `chezmoi apply`,**chezmoi** calculates the
desired contents for each of your dotfiles and then makes the minimum changes required
to make your dotfiles match your desired state

##  One-line binary install

Install the correct binary for your operating system and architecture in `./bin` with a
single command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

Alternatively, to install the `chezmoi` binary in a different directory, use the `-b`
option, for example:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

After `chezmoi` is installed, deply dotfiles with:
```sh
chezmoi init inean
````

Personal secrets are stored with [gopass](https://www.gopass.pw/) and you\'ll
need the gopass CLI(`gopass`).

## Quick start

**chezmoi** computes the target state for the current machine and then updates the
destination directory, where:

* The destination directory is the directory that **chezmoi** manages, usually your
`$HOME` directory, `~`

* A target is a file, directory, or symlink in the destination directory.

* The source directory is where chezmoi stores the source state. By default it is
`~/.local/share/chezmoi`.

* The config file contains machine-specific data. By default it is
`~/.config/chezmoi/chezmoi.toml`.

### Merge shared files into new machine

* Check what changes that **chezmoi** will make to your home directory by running:

   ```sh
   chezmoi diff
   ```

* If you are happy with the changes that **chezmoi** will make then run:

   ```sh
   chezmoi apply -v
   ```

* If you are not happy with the changes to a file then either edit it with:

   ```sh
   chezmoi edit $FILE
   ```

* Or, invoke a *merge tool* to merge changes between the current contents of the file,
   the file in your working copy, and the computed contents of the file:

   ```sh
   chezmoi merge $FILE
   ```

* On any machine, you can pull and apply the latest changes from your repo with:

   ```sh
   chezmoi update -v
   ```

### Add a new file

* to add a new with *chezmoi*:

   ```sh
   chezmoi add ~/.bashrc
   ```

   This will copy `~/.bashrc` to `~/.local/share/chezmoi/dot_bashrc`

* Edit the source state:

   ```sh
   chezmoi edit ~/.bashrc
   ```

   This will open `~/.local/share/chezmoi/dot_bashrc` in your `$EDITOR`. Make some
   changes and save the file
