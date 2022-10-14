# dotfiles

repo for storing my dotfiles. Utilises GNU stow for managing these files from a central location.

To use simply ensure the config file you want to use doesn't already exist and then run `stow <module_name>` to automatically setup a symlink to this repo.

To add a new config to this repo ensure the folder structure is correct and then move the config into this repo. You can then use stow to symlink to the original location.

The folder structure should look as follows

`dotfiles/<module_name>/path/from/home/to/file/config`

By running `stow <module_name>` from the dotfiles directory the file `config` would end up at `~/path/from/home/to/file/config`

