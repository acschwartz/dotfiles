# ⚫️ dotfiles

Annie's personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html).

## Table of Contents

- **[🚀 QuickStart](#-quickstart)**
- [⚙️ Docs: Under the Hood](#-docs-under-the-hood)
  - [📦 Packages](#-packages)
  - [📖 Basic Stow Commands](#-basic-stow-commands)
  - [⚙️ .stowrc Defaults](#️-stowrc-defaults)
- [📓 Appendix: Troubleshooting Log](#-appendix-troubleshooting-log)
- [✨ Appendix: Dotfile Inspiration](#-appendix-dotfile-inspiration)
- [🌐 Appendix: External Docs & Links](#-appendix-external-docs--links)
- [📝 To-Do's](#-todo)

---

## 🚀 QuickStart

### 🔧 Setup

#### 1. Install dependencies

On a fresh machine, first install the Stow utility.

- MacOS: `brew install stow`
- Linux: `sudo apt-get install stow`

#### 2. Clone this repo

```zsh
git clone git@github.com:acschwartz/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
```

#### ⚠️ Important Note (before you run any Stow commands)

- Always execute all `stow` commands from **repo root** directory!

#### 3. Run Stow to symlink the dotfiles

Stow is run on a per-package basis, as that is the purpose of Stow.
Run the `stow` command to create symlinks from your home folder to this repo's packages.

```zsh
stow <package1> <package2> <package3>
```

e.g. `stow zsh git vscode`
(Under-the-hood settings are managed within this repo in `.stowrc`, thus you can just run the command.)

**⚠️ If Stow produces no output, it didn't work !!**

Output should look like this:

```zsh
$ stow bin    
LINK: bin => dev/dotfiles/bin/bin
```

Use this command to run Stow on all packages: `ls -d */ 2>/dev/null | tr -d / | xargs stow`

If a target file already exists in home folder, create a backup before symlinking, e.g.:

```zsh
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```


### How-To

#### 📝 Editing Your Dotfiles

**Always edit dotfiles in the repo folder**, not in home folder (where dotfiles would traditionally live), and  ***don't forget to commit!*** 😎

#### ➕ Adding New Packages to Repo

```zsh
mkdir zsh
mv ~/.zshrc zsh/
mv ~/.zprofile zsh/
stow zsh
```

---

## 📖 Docs: Under the Hood

🧰 [**GNU Stow**](https://www.gnu.org/software/stow/manual/stow.html) is a symlink manager — it helps you manage your [**dotfiles**](https://webpro.nl/articles/getting-started-with-dotfiles) by creating symbolic links from files in this repo to your home directory.

Instead of manually symlinking each config file, you organize your dotfiles into folders (called “packages”), and run `stow <folder>` to auto-link all contents into place.

### 📦 Packages

Each folder in the repo is a Stow package.

For example:

```zsh
git/    → ~/.gitconfig  
zsh/    → ~/.zshrc, ~/.zprofile  
nvim/   → ~/.config/nvim/init.lua  
```

Why?

- Avoids dumping all dotfiles into `~` at once
- Lets you pick and choose only what you need on a new system

### 📖 Basic Stow Commands

- Only run Stow on the directories in the dotfiles folder and not the individual files.
- Run commands **from the top level** of the dotfiles repo.

```zsh
stow <folder>        # 🔗 Link all files in <folder> to target dir (defaults to ~)
stow -D <folder>     # ⛓️‍💥 Unlink (i.e., "delete") the symlinks for <folder>
stow -n <folder>     # Preview what stow *would* do (no changes made)
stow -v <folder>     # Verbose output (use -vv, -vvv for more detail)
```

For troubleshooting, I like verbosity level 4:

```zsh
stow --verbose=4 <folder>
```

#### ⚠️ MacOS Note

- Due to System Integrity Protection (SIP), Stow may silently fail to link some files (like ~/.zshrc) without any error message — ⚠️ ***even with maximum verbosity***.
  - The explicitly set `--target=~` is to prevent this failure. See 'Troubleshooting' for further detail.
- ⚠️ Despite the working fix, because failures happen silently, always **verify** that symlinks were created correctly!

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

---

## 📓 Appendix: Troubleshooting Log

[Moved to own file!](reference-troubleshooting.md)

---

## ✨ Appendix: Dotfile Inspiration

[Moved to own file!](dotfile-inspo.md)

---

## 🌐 Appendix: External Docs & Links

- [Docs: GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- **[Terminal Cheat Sheet](https://github.com/0nn0/terminal-mac-cheatsheet?tab=readme-ov-file#english-version)**

---

## 📝 TODO

- [x] 🐙 `git`
- [ ] 🐚 `zsh`
  - [x] basics: `.zprofile`, `.zshrc`
    - [ ] link disparate files in `zsh/` to `.zshrc`
- [ ] 🎨 Oh My Zsh theme
  - [ ] fix: directory display in Bullet Train theme
  - [ ] fix: ⚠️ OhMyZsh no longer updating (2026); broken aliases ??
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
- [x] 🐚 User Scripts
- [ ] 📜 Useful Scripts
- [x] `~/.stow-local-ignore`
  - to ignore specific files when symlinking (e.g., README files or notes to self), use a `.stow-local-ignore` file in the 📦 **package** folder.
- [ ] ⚠️ Stow: Consider moving Stow setup from repo root to a Stow subfolder, which would allow creation of folders other than Stow packages in the repo. (With current setup, all subdirectories of the repo must be stow packages)

