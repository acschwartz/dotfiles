# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## 📚 Table of Contents

- [📝 TODO](#-todo)
- [🚀 QuickStart](#-quickstart)
- [📎 Details](#-details)
  - [📦 Packages](#-packages)
  - [📖 Basic Stow Commands](#-basic-stow-commands)
  - [⚙️ .stowrc Defaults](#️-stowrc-defaults)
- [🤯 Troubleshooting](#-troubleshooting)
- [Appendix: 💾 Commonly Backed-Up Dotfiles & Configs](#appendix--commonly-backed-up-dotfiles--configs)

---

## 📝 TODO

- [x] 🐙 `git`
- [ ] 🐚 `zsh`
- [ ] 🎭 shell aliases 
- [ ] 🍺 `brew` (Homebrew packages (?) and `Brewfile`)  
- [ ] 🐍 Python (`pip` configs, `virtualenvwrapper`, etc.)  
- [ ] 📜 Useful Scripts
- [ ] `~/.stow-local-ignore`
    - To ignore specific files when symlinking (e.g., README files or notes to self), use a `.stow-local-ignore` file in the package folder.


---

## 🚀 QuickStart

### 🔧 Setup
```
brew install stow
git clone git@github.com:acschwartz/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
```

⚠️ Execute all `stow` commands from **repo root** directory!

### 🔗 Setup Symlinks
Symlink the dotfiles in this repo to your home folder:

```zsh
stow zsh git nvim   # Example
```

If a target file already exists in `~`, back it up first:

```zsh
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

### 📝 Edit Dotfiles

**Always edit dotfiles in the repo**, not in ~:

```zsh
code ~/dev/dotfiles/zsh/.zshrc
```

⚠️ **Don't forget to commit!** 😎


### ➕ Add New Packages

```zsh
mkdir zsh
mv ~/.zshrc zsh/
mv ~/.zprofile zsh/
stow zsh
```


---


## 📎 Details

**[GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)** is a symlink manager — it helps you manage your dotfiles by creating symbolic links from files in this repo to your home directory.

Instead of manually symlinking each config file, you organize your dotfiles into folders (called “packages”), and run stow <folder> to auto-link all contents into place.


### 📦 Packages

Each folder is a Stow package.

For example:

```zsh
git/    → ~/.gitconfig  
zsh/    → ~/.zshrc, ~/.zprofile  
nvim/   → ~/.config/nvim/init.lua  
```

Why?
* It's how Stow works 😉
* Avoids dumping all dotfiles into `~` at once
* Lets you pick and choose only what you need on a new system


### 📖 Basic Stow Commands
Run them **from the top level** of the dotfiles repo.
```zsh
stow <folder>        # 🔗 Link all files in <folder> to target dir (defaults to ~)
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
* Due to System Integrity Protection (SIP), Stow may silently fail to link some files (like ~/.zshrc) without any error message — ⚠️ ***even with maximum verbosity***. 
    * The explicitly set `--target=~` is to prevent this failure. See 'Troubleshooting' for further detail.
* ⚠️ Despite the working fix, because failures happen silently, always **verify** that symlinks were created correctly!


---


## 🤯 Troubleshooting

### Overview

**Problem**
* ❌ On macOS, `stow` appeared to work on dotfiles, but actually failed to create a symlink

**Diagnosis**
* 👉 System Integrity Protection (SIP) was preventing the operation

**Solution**
* ❗️ Must explicitly set `--target=~` to bypass SIP when linking SIP-protected files
    * Even though `stow whatever` defaults to home folder as target, SIP blocks it.
    * Setting the target *explicitly* is the fix.
* ✅ Created `.stowrc` and added `--target=~` so you don’t have to type it every time

#### Note
* ⚠️ Stow fails silently when SIP blocks it — verbosity has no effect.
* Stow works *as expected* with most files, even when the target the home folder (tested & confirmed). It's specifically dotfiles/configs that are protected by the operating system in this case.

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


## Appendix: 💾 Commonly Backed-Up Dotfiles & Configs

✨ For inspiration ✨

Anything under `~/.config/` is usually fair game for versioning if you use CLI tools or TUI apps.

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
