# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## 🧰 GNU Stow

**[GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)** is a symlink manager — it helps you manage your dotfiles by creating symbolic links from files in this repo to your home directory.

Instead of manually symlinking each config file, you organize your dotfiles into folders (called “packages”), and run stow <folder> to auto-link all contents into place.

For example:
```zsh
~/dev/dotfiles/git/.gitconfig → ~/.gitconfig
~/dev/dotfiles/zsh/.zshrc     → ~/.zshrc
```

### 📖 Basic Stow Commands
Run them **from the top level** of the dotfiles repo.
```
stow <folder>         # Link all files in <folder> to target dir (defaults to $HOME)
stow -D <folder>      # Unlink (i.e., "delete") the symlinks for <folder>
stow -n <folder>      # Preview what stow *would* do (no changes made)
stow -v <folder>      # Increase verbosity by 1 level (add multiple -v’s for more detail, e.g. -vv)
```

### ⚙️ `.stowrc` Defaults
This repo includes a `.stowrc` file to define default flags for every Stow command:
```zsh
--target=~            # Normally optional, but required in our use case due to macOS SIP
--verbose=1           # Default set for minimal feedback, since stow’s default (0) gives no output at all
```

#### 🛑 MacOS Note
Due to System Integrity Protection (SIP), Stow may silently fail to link some files (like ~/.zshrc) without any error message — ***even with maximum verbosity***. 

The explicitly set `--target=~` is to prevent this failure. See 'Troubleshooting' for further detail.


---
## ℹ️ Instructions

All instructions assume repo lives in `~/dev/`.

### 📦 Structure

Each subfolder is a “package” managed by `stow`.

For *example*:

```
├── git/          → ~/.gitconfig
├── nvim/         → ~/.config/nvim/init.lua
├── zsh/          → ~/.zshrc, ~/.zprofile
```

---

### 💻 New machine - initial bootstrap

On a new machine, you must first install `homebrew`, then `stow`.

MacOS does not ship with `stow` out of the box.

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install stow
```


### 🚀🔗 Installing from repo
*After setup, your local dotfiles will be symlinked to the contents of this repo.*

1. Clone repo
```zsh
git clone git@github.com:username/dotfiles.git ~/dev/dotfiles
```

2. (section deleted)

3. Use `stow` to create the symlinks

```zsh
cd ~/dev/dotfiles
stow folder1 folder2 folder3
```

e.g. `stow git zsh nvim`

Make sure you are working from the repo's top level.

Use `stow` in verbose mode (`-v`).


#### ⚠️ Conflicts

If a file like `~/.zshrc` already exists and is not a symlink, `stow` will error out.

To fix:

```zsh
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

4. ✔️ Done!

---

### 🛠️ Managing Your Dotfiles

After your dotfiles are symlinked into place, always edit the files in the repo — not the symlink targets in your home directory directly.

For example, to edit your Zsh config:

```zsh
code ~/dev/dotfiles/zsh/.zshrc
```

**⚠️ Remember to commit!** 😎

---

## ➕✨ Adding New Dotfiles Sets


Want to manage more config files? Add new sets by:

1. **Create a new folder** in the **root of this repo**, named after the tool or purpose — for example, `brew/` to manage Homebrew setup files.

```zsh
cd ~/dev/dotfiles
mkdir brew
```

2.	**Move the config files inside this folder**.

For Homebrew, this might be a Brewfile that lists all your installed packages:

```zsh
mv ~/Brewfile brew/Brewfile
```

3. ** Use `stow` to symlink the new set**:

```zsh
stow brew
```

---

## Appendix A: 🤯 Troubleshooting Stow on macOS

### Overview

😱 **Problem**
* ❌ `stow` appeared to work on dotfiles, but actually failed to create a symlink

🩺 **Diagnosis**
* 👉 macOS System Integrity Protection (SIP) was preventing the operation

✅ **Solution**
* ❗️ must specify target explicitly to bypass SIP: `stow --target=~ <folder>` (when working with system-protected config files in macOS) 
* created `.stowrc` for this repo & added `--target=~` to prevent having to type the fix w/ every command

#### Note
* ⚠️ When Stow fails due to SIP, it fails silently ***regardless of the level of verbosity***. Increasing verbosity is not a workaround! 
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
- [ ] VS Code (settings, extensions, keybindings)
- [ ] AWS CLI config ?
- [ ] `~/.stow-local-ignore`
    - To ignore specific files when symlinking (e.g., README files or notes to self), use a `.stow-local-ignore` file in the package folder.
- [ ] Figure out what to do with useful scripts — keep here or separate repo?

---

## Appendix C: 💾 Commonly Backed-Up Dotfiles & Configs

For inspiration. 

* Anything under `~/.config/` is usually fair game for versioning if you use CLI tools or TUI apps.

### 🐚 Shell-related
* `~/.zshrc`, `~/.zprofile`, `~/.zlogin` – Zsh configs
* `~/.bashrc`, `~/.bash_profile` – Bash configs (if still using Bash)
* `~/.aliases` – custom aliases file (often sourced from `.zshrc`)
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
    * untested ChatGPT suggestion; use with caution:
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
* `~/.aws/credentials` and `config` – AWS CLI
    * who tf backs up credentials lolol
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
