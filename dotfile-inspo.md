# ✨ Dotfile Inspiration

## 📖 Contents

- [💾 Commonly Backed-Up Dotfiles & Configs](#-commonly-backed-up-dotfiles--configs)
- [📚 Example Repo Library](#-example-repo-library)

---

## 💾 Commonly Backed-Up Dotfiles & Configs

Anything under `~/.config/` is usually fair game for versioning if you use CLI tools or TUI apps.

### 🐚 Shell-related

- `~/.zshrc`, `~/.zprofile`, `~/.zlogin` – Zsh configs
- `~/.bashrc`, `~/.bash_profile` – Bash configs (if still using Bash)
- `~/.aliases` – custom aliases file (usually sourced in `.zshrc`)
- `~/.exports` – exported env vars (ditto)
- `~/.functions` – shell functions (ditto)
- `~/.profile` – sometimes used for login shell config
- `~/.inputrc` – Readline config (affects shell input behavior)

### 💻 Editor configs

- `~/.vimrc`, `~/.vim/` – Vim config

- `~/.config/nvim/` – Neovim (usually contains init.vim or init.lua)
- `~/.emacs.d/`, `~/.emacs` – Emacs
- `~/Library/Application Support/Code/User/` – VS Code settings (`settings.json`, `keybindings.json`, `snippets/`, extensions list via script)
- VSCode:
  - Save extensions: `code --list-extensions > vscode/extensions.txt`
  - Restore on new machine: `cat vscode/extensions.txt | xargs -n 1 code --install-extension`

### 🧪 Language/toolchain settings

- Python
  - Python dev aliases
    - `alias py="python3"`
    - `alias venv="python3 -m venv venv && source venv/bin/activate"`
    - `alias act="source venv/bin/activate"`
    - `alias pipi="pip install"`
    - `alias pipr="pip install -r requirements.txt"`
    - `alias serve="python3 -m http.server"`
  - `~/.pythonrc.py` – custom Python interactive shell config
  - `pyenv` – Manage Python versions per-project
  - `virtualenvwrapper` – Easier management of virtual environments
  - `pipx` – Install CLI Python tools in isolation
  - `poetry` or `pipenv` – Dependency and packaging management
  - `black` – Code formatter
  - `flake8`, `mypy` – Linting and static type checking
  - `httpie` – Modern alternative to curl, written in Python
  - `fzf`, `fd`, `ripgrep` – Common shell power tools to combine with Python scripts

- `~/.npmrc` – npm config
- `~/.nvm/` – Node Version Manager (you may want to re-install with a script instead of syncing)
- `~/.rbenv/`, `~/.gemrc` – Ruby-related configs
- `~/.config/poetry/` – Python Poetry config
- `~/.cargo/` – Rust config

### 📦 Package manager

- `~/.Brewfile` or `Brewfile` – Homebrew packages (`brew bundle dump`)

- `~/.config/homebrew/` – if you customize paths or taps

### 🌐 Cloud & CLI tools

- `~/.aws/config` – AWS CLI

- `~/.azure/`, `~/.gcloud/` – Other cloud CLIs
- `~/.ssh/` – keys and config (be careful with permissions and secrets!)
  - config file contains host aliases, ports, and other settings — it’s safe (and useful) to version.
  - keys can be kept in secrets manager like Bitwarden
- `~/.gitconfig`, ~/.gitignore_global – Git settings
- `~/.docker/` – Docker CLI config

### 🧰 Misc Dev Tools

- `~/.config/htop/` – `htop` config

- `~/.config/lazygit/`
- `~/.tmux.conf, ~/.tmux/`

---

## 📚 Example Repo Library

### 🏆 Popular

- 🐙 **[GitHub topic: dotfiles](https://github.com/topics/dotfiles)**
- 🌟 **[dotfiles.github.io](https://dotfiles.github.io/)** – Community project listing hundreds of dotfile repos.
- [**Mathias Bynens**’ dotfiles](https://github.com/mathiasbynens/dotfiles)
- [**Paul Irish**’s dotfiles](https://github.com/paulirish/dotfiles)

### 🧼 Minimalist macOS Dotfiles

- [webpro/dotfiles](https://github.com/webpro/dotfiles) – Minimal, well-organized macOS setup with a great bootstrap script.
- [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles) – Lightweight, includes Vim, tmux, and zsh configs.
- [holman/dotfiles](https://github.com/holman/dotfiles) – From Zach Holman (ex-GitHub), modular structure, easy to customize.

### 🍎 macOS Power Users

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) – Legendary repo, tons of macOS tweaks and shell customizations.
- [🍏 driesvints/dotfiles](https://github.com/driesvints/dotfiles) – Laravel core team member, great macOS dev stack setup.
- [paulirish/dotfiles](https://github.com/paulirish/dotfiles) – Front-end-focused but full of shell and Git enhancements.

### 🛠️ DevOps / Terminal Power Tools

- [jessfraz/dotfiles](https://github.com/jessfraz/dotfiles) – Ex-Google/Netflix engineer, hardcore Docker/Kubernetes/CLI stack.
- [geerlingguy/dotfiles](https://github.com/geerlingguy/dotfiles) – Ansible-heavy, good for automation-focused devs.
- [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles) – Ruby/devops shop, tmux + vim + shell tuned for productivity.

### 🐍 Python Developers

- [kdeldycke/dotfiles](https://github.com/kdeldycke/dotfiles) – macOS dotfiles optimized for Python developers using Neovim and VSCode. ★1.1k

### 🎁 Bonus: Starter Template Generators

- [dotbot](https://github.com/anishathalye/dotbot) – Tool for bootstrapping and managing dotfiles cleanly across machines.
- [yadm](https://github.com/TheLocehiliosan/yadm) – Dotfile manager using Git, supports encryption and alt files.

---
