# ==============================================================================
# =       🚀 Zsh Run Commands   (.zshrc - Interactive Shell Config)            =
# ==============================================================================

# This is an edit of the stock Oh-My-Zsh rc to make it more readable.
#  I've left in all of the OMZ instructional comments for reference,
#  plus added additional clarifying comments.

# ====================== 📝 Notes ==============================================
# .zprofile     run once at login
# .zshrc        run every time you open a new tab/window

# On macOS, Terminal apps launch your shell as a login shell by default
# which means both .zprofile and .zshrc run.
#  _____________________________________________________________________________

## .zshrc (interactive shell config):
#  Used for settings that you want to apply every time
#  a new interactive shell starts (each new Terminal tab or window).
#
#  Examples:
#     - Aliases: shortcuts for commands, like alias ll='ls -la'.
#     - Custom functions: shell functions you want to define.
#     - PATH edits: additional path changes that are specific to
#       interactive shells or temporary tweaks.
#     - Exported vars: environment variables you want to set or override
#       ONLY for interactive shells — like EDITOR=vim or LANG=en_US.UTF-8.
#     - Other shell tweaks, prompt customization, plugin loading.
# ______________________________________________________________________________

# ==============================================================================
# =                  🐚  Zsh Core Environment                                  =
# ==============================================================================
# This env var contains the path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# ==============================================================================
# =                   🔮  Oh My Zsh Configs                                    =
# ==============================================================================

# ========================== 🌈 Theme ===========================================
# 📁 Official themes:       $ZSH/themes/
# 📁 Custom user themes:    $ZSH_CUSTOM/themes/

## Theme Catalog:  https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

## Tip: Preview a theme temporarily 👀
#   - To try a theme in terminal without editing your .zshrc,
#   - temporarily apply a theme to the current session by running:
#     ZSH_THEME="agnoster" source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"
#  - "random" loads a random theme each time Oh My Zsh is loaded
#  - to know which one was loaded, run: echo $RANDOM_THEME

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#   - Set list of themes to pick from when loading at random.
#   - Setting this variable when ZSH_THEME=random will cause zsh to load
#   a theme from this variable instead of looking in $ZSH/themes/
#   - If set to an empty array, this variable will have no effect.


# ========================== 💫 Plugins =========================================
# 📁 Official plugins:          $ZSH/plugins/
# 📁 Custom user plugins:       $ZSH_CUSTOM/plugins/

plugins=(git)
#  - Example format: plugins=(rails git textmate ruby lighthouse)
#  - (!) Add wisely, as too many plugins slow down shell startup.


# ======================== 📁 Custom Folder Path ================================
# - Oh My Zsh updates overwrite files in $ZSH (official plugins/themes).
# - Your custom plugins/themes in $ZSH_CUSTOM are kept safe and never overwritten.
# - Use $ZSH_CUSTOM to add or modify plugins and themes without losing changes.

# ZSH_CUSTOM=/path/to/new-custom-folder
#   - defaults to $ZSH/custom if not set


# ====================== 🔎 Completion Settings =================================
# CASE_SENSITIVE="true"
#   - Uncomment to use case-sensitive completion.

# HYPHEN_INSENSITIVE="true"
#   - Uncomment to use hyphen-insensitive completion.
#   - Case-sensitive completion must be off. _ and - will be interchangeable.

# COMPLETION_WAITING_DOTS="true"
#   - Uncomment to display red dots whilst waiting for completion.
#   - You can also set it to another string to have that shown, 
#     instead of the default red dots, e.g.
#       COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)


# ======================= 🔄 Auto-Update Settings ===============================
# Uncomment one of the following lines to change the auto-update behavior:
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days):
# zstyle ':omz:update' frequency 13


# ======================== 🧙 Shell Behavior Tweaks =============================
# DISABLE_MAGIC_FUNCTIONS="true"
#   - Uncomment if 'pasting URLs and other text is messed up'.

# DISABLE_LS_COLORS="true"
#   - Uncomment to disable colors in ls.

# DISABLE_AUTO_TITLE="true"
#   - Uncomment to disable auto-setting terminal title.

# ENABLE_CORRECTION="true"
#   - Uncomment to enable command auto-correction.
#   - Tried 05/2025. Did not like it.


# =============== 🐢 Git Performance Optimization for Large Repos ===============
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#   - Uncomment if you want to disable marking untracked files under VCS as dirty. 
#   - This makes repository status check for large repositories much, much faster.


# ====================== ⌛️ History Timestamp Format ===========================
# HIST_STAMPS="mm/dd/yyyy"
#   - Uncomment if you want to change the command execution time stamp
#     shown in the history command output.
#   - You can set one of the optional three formats:
#           "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
#     or set a custom format using the strftime function format specifications,
#     see 'man strftime' for details.


# ==============================================================================
# =                  🚀  Initialize Oh My Zsh !                                =
# ==============================================================================
# Starts Oh My Zsh — applies theme, plugins, and settings
source $ZSH/oh-my-zsh.sh


# ==============================================================================
# =                        🦄  User Configs                                    =
# ==============================================================================
# This is where you add your own settings.
# You’re encouraged to define:
#	•	Aliases
#	•	Custom functions
#	•	PATH edits (rare): additional path changes that are specific
#         to interactive shells or temporary tweaks.
#	•	Exported vars: environment variables you want to set or override
#         only for interactive shells — (like EDITOR, LANG, etc.).
# 	•	Local tweaks and personal additions
# ______________________________________________________________________________

# ========================= 🎭 Personal Aliases =================================
# ⚠️ Personal aliases OVERRIDE those provided by
#    Oh My Zsh libs, plugins, and themes!

# Oh My Zsh users are encouraged to define aliases within 
# a top-level file in the $ZSH_CUSTOM folder, with .zsh extension.
# Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh

## 🎭 Source my outside aliases file
source ~/.aliases

# For a full list of active aliases, run `alias`
# (which itself is an alias set by OMZ)


# ============================ 🌀 Other Stuff ===================================
## 🌐 Environment Vars
# On modern systems (like macOS with Homebrew), man usually finds everything it needs automatically.
# export MANPATH="/usr/local/man:$MANPATH"      # Manual setup of `man` command

# You may need to manually set your language environment:
# export LANG=en_US.UTF-8

## ✍️ Editor Settings - Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

## 🧱 Compilation Flags
# export ARCHFLAGS="-arch $(uname -m)"


# ======================== 🚀 Startup Scripts ===================================
## 🎨 Test out Terminal Themes (distinct from OMZ themes):
# Uncomment when deciding between multiple terminal colors!
# terminal_profile=$(osascript -e 'tell application "Terminal" to get name of current settings of front window')
# echo; neofetch    # 🍎🌈
# for color in black white red green yellow blue magenta cyan; do
#   print -P "%B%F{$color}$terminal_profile%f%b %F{$color} $color $color $color $color $color $color%f"
# done

# ______________________________________________________________________________
