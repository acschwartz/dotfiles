# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

This repo organizes all my shell and tool configuration in a modular way, making it easy to symlink into place and keep version-controlled across machines.

---

## 📦 Structure

Each subfolder is a “package” managed by `stow`. For example:

```
├── bash/         → ~/.bashrc, ~/.bash_profile
├── git/          → ~/.gitconfig
├── nvim/         → ~/.config/nvim/init.lua
├── zsh/          → ~/.zshrc, ~/.zprofile
```

---

## 🔗 Installing

To set up everything:

```bash
git clone git@github.com:acschwartz/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
stow bash git zsh nvim
```

Run stow <folder> to install specific components, or stow -D <folder> to remove them.

### ⚠️ Conflicts

If a file like `~/.bashrc` already exists and is not a symlink, `stow` will complain.
To fix:

```
mv ~/.bashrc ~/.bashrc.backup
stow bash
```

---