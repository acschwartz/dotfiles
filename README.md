# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## 🧰 GNU Stow

**[GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)** is a symlink manager — it helps you manage your dotfiles by creating symbolic links from files in this repo to your home directory.

Instead of manually symlinking each config file, you organize your dotfiles into folders (called “packages”), and run stow <folder> to auto-link all contents into place.


### 📦 Packages

Each folder in the repo is a stow package.

For example:

```zsh
git/    → ~/.gitconfig  
zsh/    → ~/.zshrc, ~/.zprofile  
nvim/   → ~/.config/nvim/init.lua  
```


### 📖 Basic Stow Commands
Run them **from the top level** of the dotfiles repo.
```zsh
stow <folder>        # 🔗 Link all files in <folder> to target dir (defaults to $HOME)
stow -D <folder>     # ⛓️‍💥 Unlink (i.e., "delete") the symlinks for <folder>
stow -n <folder>     # Preview what stow *would* do (no changes made)
stow -v <folder>     # Verbose output (use -vv, -vvv for more detail)
```

### ⚙️ `.stowrc` Defaults
This repo includes a `.stowrc` file to define default flags for every Stow command:
```zsh
--target=~     # Normally optional, but required in my case due to macOS SIP
--verbose=1    # Enables minimal output (Stow default is silent)
```

#### 🛑 MacOS Note
Due to System Integrity Protection (SIP), Stow may silently fail to link some files (like ~/.zshrc) without any error message — ***even with maximum verbosity***. 

The explicitly set `--target=~` is to prevent this failure. See 'Troubleshooting' for further detail.


---


## ℹ️ Instructions

Prerequisites:
* Stow installed (`brew install stow`)
* Repo cloned to `~/dev/dotfiles`


### 🚀🔗 Symlink Dotfiles

```zsh
cd ~/dev/dotfiles
stow <pkg1> <pkg2> <pkg3>
stow zsh git nvim  # Example
```

#### Conflicts

If a target file already exists in `~`, back it up:

```zsh
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

### 🛠️📝 Edit Dotfiles

Edit files **only** in the repo:

```zsh
code ~/dev/dotfiles/zsh/.zshrc
```

⚠️ **Don't forget to commit!** 😎


### ➕✨ Add New Packages

1. Make new folder in repo root
2. Move config(s) inside
3. `stow <folder>`


```zsh
cd ~/dev/dotfiles
mkdir zsh
mv ~/.zshrc zsh/
mv ~/.zprofile zsh/
stow zsh
```


---

## Appendix A: 🤯 Troubleshooting Stow on macOS

### Overview

😱 **Problem**
* ❌ `stow` appeared to work on dotfiles, but actually failed to create a symlink

🩺 **Diagnosis**
* 👉 MacOS System Integrity Protection (SIP) was preventing the operation

✅ **Solution**
* ❗️ Explicitly set `--target=~` to bypass SIP when linking protected files
* created `.stowrc` for this repo & added `--target=~` to prevent having to type the fix w/ every command

#### Note
* ⚠️ Stow fails silently when SIP blocks it — verbosity has no effect.
* Stow works as expected with normal files, even when the target the home folder (tested & confirmed). It's specifically dotfiles/configs that are protected by the operating system.

### Troubleshooting Detail

#### Terminal Commands

* `ll file` (alias for `ls -l file`)
    * list file info, long version
* `ln -s ~/dev/dotfiles/git/.gitconfig ~/.gitconfig`
    * create symlink (manually)
* `dtruss`
    * 'see what Stow is actually doing under the hood'


#### Troubleshooting Log
This was prior to creation of `.stowrc`, so there are no default flags set beyond what is seen.

```zsh
➜  cd ~/dev/dotfiles
➜  stow -D -v git
UNLINK: .gitconfig
➜  stow -v git
LINK: .gitconfig => dotfiles/git/.gitconfig
➜  ll ~/.gitconfig
ls: /Users/annie/.gitconfig: No such file or directory
➜  stat ~/.gitconfig
stat: /Users/annie/.gitconfig: stat: No such file or directory
➜  ln -s ~/dev/dotfiles/git/.gitconfig ~/.gitconfig
➜  ll ~/.gitconfig
lrwxr-xr-x  1 annie  staff  40 May 24 19:29 /Users/annie/.gitconfig -> /Users/annie/dev/dotfiles/git/.gitconfig
➜  rm ~/.gitconfig
➜  ll ~/.gitconfig
ls: /Users/annie/.gitconfig: No such file or directory
➜  stow --version    
stow (GNU Stow) version 2.4.1
➜  echo $HOME
/Users/annie
➜  sudo dtruss stow -v  git
dtrace: system integrity protection is on, some features will not be available
dtrace: failed to execute stow: Operation not permitted
```

The above shows:

* ✅ You’re using GNU Stow (2.4.1).
* ✅ $HOME is correctly set to /Users/annie.
* ✅ Manual symlinking works as expected.
* ✅ Stow believes it’s creating the link (LINK: .gitconfig => dotfiles/git/.gitconfig).
* ❌ After running Stow, the symlink does not appear.
* ❌ `dtrace` identifies Stow failed due to System Integrity Protection


---


## Appendix B: 📝 TODO

- [ ] `zsh`
- [x] `git`
- [ ] Backup shell aliases 
- [ ] Brew (Homebrew packages (?) and Brewfile)  
- [ ] Python (`pip` configs, `virtualenvwrapper`, etc.)  
- [ ] Useful Scripts: keep here or move to a separate repo?
- [ ] `~/.stow-local-ignore`
    - To ignore specific files when symlinking (e.g., README files or notes to self), use a `.stow-local-ignore` file in the package folder.


---


## Appendix C: 💾 Commonly Backed-Up Dotfiles & Configs

For inspiration. 

* Anything under `~/.config/` is usually fair game for versioning if you use CLI tools or TUI apps.

### 🐚 Shell-related
* `~/.zshrc`, `~/.zprofile`, `~/.zlogin` – Zsh configs
* `~/.bashrc`, `~/.bash_profile` – Bash configs (if still using Bash)
* `~/.aliases` – custom aliases file (usually sourced in `.zshrc`)
* `~/.exports` – exported env vars (ditto)
* `~/.functions` – shell functions (ditto)
* `~/.profile` – sometimes used for login shell config
* `~/.inputrc` – Readline config (affects shell input behavior)

### 💻 Editor configs
* `~/.vimrc`, `~/.vim/` – Vim config
* `~/.config/nvim/` – Neovim (usually contains init.vim or init.lua)
* `~/.emacs.d/`, `~/.emacs` – Emacs
* `~/Library/Application Support/Code/User/` – VS Code settings (`settings.json`, `keybindings.json`, `snippets/`, extensions list via script)
* VSCode:
    * untested ChatGPT suggestion; use as reference:
    ```
    # Save extensions
    code --list-extensions > vscode/extensions.txt

    # Restore on new machine
    cat vscode/extensions.txt | xargs -n 1 code --install-extension
    ```

### 🧪 Language/toolchain settings
* `~/.pythonrc.py` – custom Python interactive shell config
* `~/.npmrc` – npm config
* `~/.nvm/` – Node Version Manager (you may want to re-install with a script instead of syncing)
* `~/.rbenv/`, `~/.gemrc` – Ruby-related configs
* `~/.config/poetry/` – Python Poetry config
* `~/.cargo/` – Rust config

### 📦 Package manager
* `~/.Brewfile` or `Brewfile` – Homebrew packages (`brew bundle dump`)
* `~/.config/homebrew/` – if you customize paths or taps

### 🌐 Cloud & CLI tools
* `~/.aws/config` – AWS CLI
* `~/.azure/`, `~/.gcloud/` – Other cloud CLIs
* `~/.ssh/` – keys and config (be careful with permissions and secrets!)
    * config file contains host aliases, ports, and other settings — it’s safe (and useful) to version.
    * keys can be kept in secrets manager like Bitwarden
* `~/.gitconfig`, ~/.gitignore_global – Git settings
* `~/.docker/` – Docker CLI config

### 🧰 Misc Dev Tools
* `~/.config/htop/` – `htop` config
* `~/.config/lazygit/`
* `~/.tmux.conf, ~/.tmux/`
