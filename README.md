# dotfiles

Annie's personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

## 📖 Table of Contents

- [📝 TODO](#-todo)
- [🚀 QuickStart](#-quickstart)
- [📎 Details](#-details)
  - [📦 Packages](#-packages)
  - [📖 Basic Stow Commands](#-basic-stow-commands)
  - [⚙️ .stowrc Defaults](#️-stowrc-defaults)
- [🤯 Troubleshooting](#-troubleshooting)
- [✨ Appendix: Inspiration](#-appendix-inspiration)

---

## 📝 TODO

- [x] 🐙 `git`
- [ ] 🐚 `zsh`
    - [x] basics: `.zprofile`, `.zshrc`
    - [ ] link disparate files in `zsh/` to `.zshrc`
- [ ] 🎨 Oh My Zsh theme
    - [ ] fix: directory display in Bullet Train theme
- [ ] 🎭 shell [aliases](https://github.com/driesvints/dotfiles?tab=readme-ov-file#your-own-dotfiles) 
    - [x] create `zsh/.alias`
    - [ ] fill it in - [ideas](https://github.com/driesvints/dotfiles/blob/main/aliases.zsh)
- [ ] 🧬 VSCode
    - [x] global `settings.json`
    - [x] local `settings.json` for this repo/workspace
    - [ ] ❓ extensions
        - [ ] ❓ figure out why uninstalled extensions are still in my folder 😠
- [ ] 🍺 `brew` (Homebrew packages (?) and [Brewfile](https://github.com/jbranchaud/til/blob/master/brew/export-list-of-everything-installed-by-brew.md))  
- [ ] 🐍 Python (`pip` configs, `virtualenvwrapper`, etc.)  
- [ ] 📜 Useful Scripts
- [x] `~/.stow-local-ignore`
    - to ignore specific files when symlinking (e.g., README files or notes to self), use a `.stow-local-ignore` file in the 📦 **package** folder.


---

## 🚀 QuickStart

### 🔧 Setup
```
brew install stow
git clone git@github.com:acschwartz/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
```

### ⚠️ Important !
- Execute all `stow` commands from **repo root** directory!
- Only run `stow` on the directories (packages) in the dotfiles folder and **not** the individual files.

### 🔗 Setup Symlinks
Symlink the dotfiles in the named packages (of this repo) to your home folder:

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
git commit -a
```

⚠️ ***Don't forget to commit!*** 😎


### ➕ Add New Packages

```zsh
mkdir zsh
mv ~/.zshrc zsh/
mv ~/.zprofile zsh/
stow zsh
```


---


## 📎 Details

🧰 [**GNU Stow**](https://www.gnu.org/software/stow/manual/stow.html) is a symlink manager — it helps you manage your [**dotfiles**](https://webpro.nl/articles/getting-started-with-dotfiles) by creating symbolic links from files in this repo to your home directory.

Instead of manually symlinking each config file, you organize your dotfiles into folders (called “packages”), and run `stow <folder>` to auto-link all contents into place.


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
* Only run Stow on the directories in the dotfiles folder and not the individual files.
* Run commands **from the top level** of the dotfiles repo.

```zsh
stow <folder>        # 🔗 Link all files in <folder> to target dir (defaults to ~)
stow -D <folder>     # ⛓️‍💥 Unlink (i.e., "delete") the symlinks for <folder>
stow -n <folder>     # Preview what stow *would* do (no changes made)
stow -v <folder>     # Verbose output (use -vv, -vvv for more detail)
```

For troubleshooting, I recommend using:
```zsh
stow --verbose=4 <folder>
```

#### ⚠️ MacOS Note
* Due to System Integrity Protection (SIP), Stow may silently fail to link some files (like ~/.zshrc) without any error message — ⚠️ ***even with maximum verbosity***. 
    * The explicitly set `--target=~` is to prevent this failure. See 'Troubleshooting' for further detail.
* ⚠️ Despite the working fix, because failures happen silently, always **verify** that symlinks were created correctly!


### ⚙️ `.stowrc` Defaults
This repo includes a `.stowrc` file to define default flags for every Stow command:
```zsh
--target=~               # Normally optional, but required in my case due to macOS SIP
--verbose=1              # Enables minimal output (Stow default is silent)
--ignore='<perl regex>'  # Any repo-level ignores
```

### 🛑 Stow Ignore Files
Stow uses **Perl-style regex** in its ignore files.

#### 📦 Package-level ignores
- `.stow-local-ignore`
- Put in **package folder** to ignore files *in that package only*.  
- 🚫 Won’t work from repo root — must be inside the package.

#### 🏠 Global (machine-level) ignores
- `.stow-global-ignore`
- Put in **`~` (home dir)** to ignore files/folders *across all packages* on your machine.  
- 🚫 Won’t work from repo or elsewhere — must be at `~`.

#### 📁 Repo-level ignores
- `.stowrc`
- Set **`.stowrc`** `--ignore` flags in the **repo root** to ignore files/packages across the repo.
- *(🧙✋🏻 `.stow-local-ignore` and `.stow-global-ignore` have no power here!)*



## 🤯 Troubleshooting

### Overview

**Problem**
* ❌ On macOS, `stow` appeared to work on dotfiles, but actually failed to create a symlink

**Diagnosis**
* 👉 System Integrity Protection (SIP) was quietly preventing the operation

**Solution**
* ❗️ Must explicitly set `--target=~` to bypass SIP when linking SIP-protected files
    * Even though `stow whatever` defaults to home folder as target, SIP blocks the operation
    * Setting the target *explicitly* is the fix
* ✅ Created `.stowrc` and added `--target=~` so you don’t have to type it every time

#### Note
* ⚠️ Stow fails silently when SIP blocks it — verbosity has no effect.
* Stow works *as expected* with most files, even when the home folder is used as the default target & not explicitly invoked (tested & confirmed). It's specifically dotfiles/configs that are protected by the operating system in this case.

### Troubleshooting Details

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
* ❗️ `dtrace` identifies Stow failed due to System Integrity Protection


---

## ✨ Appendix: Inspiration

[Moved to own file!](dotfile-inspo.md)
