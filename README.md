# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

This repo organizes all my shell and tool configuration in a modular way, making it easy to symlink into place and keep version-controlled across machines.

---

## 📦 Structure

Each subfolder is a “package” managed by `stow`.
For *example*:

```
├── git/          → ~/.gitconfig
├── nvim/         → ~/.config/nvim/init.lua
├── zsh/          → ~/.zshrc, ~/.zprofile
```

---


## 📝 To-Do

- [ ] `zsh`
- [ ] `git`
- [ ] Backup shell aliases 
- [ ] Brew (Homebrew packages (?) and Brewfile)  
- [ ] Python (`pip` configs, `virtualenvwrapper`, etc.)  
- [ ] VS Code (settings, extensions, keybindings)  
- [ ] AWS CLI config ?
- [ ] Figure out what to do with useful scripts — keep here or separate repo?

Feel free to add more as you discover new tools or configs you want tracked.

---

## Instructions

### 🚀🔗 Installing from Repo

How to restore config files from repo:

```zsh
git clone git@github.com:username/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
stow git zsh nvim
```

* `stow <folder>` to symlink a module
* `stow -D <folder>` to unlink

#### ⚠️ Conflicts

If a file like `~/.zshrc` already exists and is not a symlink, `stow` will complain.
To fix:

```zsh
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

After setup, your local dotfiles will be symlinked to the contents of this repo.

---

### 🛠️ Managing Your Dotfiles

After your dotfiles are symlinked into place, always edit the files in the repo — not the symlink targets in your home directory directly.

For example, to edit your Zsh config:

```zsh
code ~/dev/dotfiles/zsh/.zshrc
```

**⚠️ Remember to commit!**

---

### ➕✨ Adding New Dotfiles Sets


Want to manage more config files? Add new sets by:

1. **Create a new folder** in the **root of this repo**, named after the tool or purpose — for example, `brew/` to manage Homebrew setup files.

```zsh
cd ~/dev/dotfiles
mkdir brew
```

2.	**Copy or create the config files inside this folder**, preserving the relative paths you want in your home directory. For Homebrew, this might be a Brewfile that lists all your installed packages:

```zsh
cp ~/Brewfile brew/Brewfile
```

3. ** Use `stow` to symlink the new set**:

```zsh
stow brew
```

#### 🔍 Preview Symlinks with Stow

To see what `stow` will symlink without making any changes, run:

```bash
stow -n <folder>
```

or

```bash
stow --no <folder>
```

---
## Appendix

### 💾 Commonly Backed-Up Dotfiles & Configs
Anything under `~/.config/` is usually fair game for versioning if you use CLI tools or TUI apps.

#### 🐚 Shell-related
* `~/.zshrc`, `~/.zprofile`, `~/.zlogin` – Zsh configs
* `~/.bashrc`, `~/.bash_profile` – Bash configs (if still using Bash)
* `~/.aliases` – custom aliases file (often sourced from `.zshrc`)
* `~/.exports` – exported env vars (ditto)
* `~/.functions` – shell functions (ditto)
* `~/.profile` – sometimes used for login shell config
* `~/.inputrc` – Readline config (affects shell input behavior)

#### 💻 Editor configs
* `~/.vimrc`, `~/.vim/` – Vim config
* `~/.config/nvim/` – Neovim (usually contains init.vim or init.lua)
* `~/.emacs.d/`, `~/.emacs` – Emacs
* `~/Library/Application Support/Code/User/` – VS Code settings (`settings.json`, `keybindings.json`, `snippets/`, extensions list via script)

#### 🧪 Language/toolchain settings
* `~/.pythonrc.py` – custom Python interactive shell config
* `~/.npmrc` – npm config
* `~/.nvm/` – Node Version Manager (you may want to re-install with a script instead of syncing)
* `~/.rbenv/`, `~/.gemrc` – Ruby-related configs
* `~/.config/poetry/` – Python Poetry config
* `~/.cargo/` – Rust config

#### 📦 Package manager
* `~/.Brewfile` or `Brewfile` – Homebrew packages (`brew bundle dump`)
* `~/.config/homebrew/` – if you customize paths or taps

#### 🌐 Cloud & CLI tools
* `~/.aws/credentials` and `config` – AWS CLI
    * who tf backs up credentials lolol
* `~/.azure/`, `~/.gcloud/` – Other cloud CLIs
* `~/.ssh/` – keys and config (be careful with permissions and secrets!)
    * config file contains host aliases, ports, and other settings — it’s safe (and useful) to version.
    * keys can be kept in secrets manager like Bitwarden
* `~/.gitconfig`, ~/.gitignore_global – Git settings
* `~/.docker/` – Docker CLI config

#### 🧰 Misc Dev Tools
* `~/.config/htop/` – `htop` config
* `~/.config/lazygit/`
* `~/.tmux.conf, ~/.tmux/`
* `~/.stow-local-ignore` – if using Stow with ignored files
