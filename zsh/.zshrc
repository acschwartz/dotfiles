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

ZSH_THEME="bullet-train"
# ZSH_THEME="random"
#  - "random" loads a random theme each time Oh My Zsh is loaded
#  - to know which one was loaded, run: echo $RANDOM_THEME

ZSH_THEME_RANDOM_CANDIDATES=( "bullet-train" "amuse" "ys")
# ZSH_THEME_RANDOM_CANDIDATES=( "bullet-train" "amuse" "ys"  "wedisagree" "cloud"  "gnzh" "sunrise")
# ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster" )      # defaults
#   - Set list of themes to pick from when loading at random.
#   - Setting this variable when ZSH_THEME=random will cause zsh to load
#   a theme from this variable instead of looking in $ZSH/themes/
#   - If set to an empty array, this variable will have no effect.


## 💡 Tip: PREVIEW themes temporarily 👀
# To try a theme in your current session without editing your .zshrc,
# use themes plugin (installed):
#   ⭐️  lstheme              list installed themes  
#   ⭐️  theme <name>         change theme
#   ⭐️  theme                changes theme to random        
# ( pretty sure this just executes `ZSH_THEME="name"; source $ZSH/oh-my-zsh.sh``)



# ================== 🚄 Bullet Train Theme Config ===============================
# Config options: https://github.com/caiogondim/bullet-train.zsh/

# BULLETTRAIN_TIME_12HR=true
BULLETTRAIN_DIR_EXTENDED=1              # 1 = medium detail
BULLETTRAIN_CONTEXT_DEFAULT_USER=annie
BULLETTRAIN_CONTEXT_HOSTNAME=💻
BULLETTRAIN_PROMPT_ADD_NEWLINE=true
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_STATUS_EXIT_SHOW=true       # show exit code of last command

### Color changes by segment

# Directory
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_DIR_BG=blue

# Time
BULLETTRAIN_TIME_BG=black
BULLETTRAIN_TIME_FG=cyan
# time: black-on-white
# BULLETTRAIN_TIME_BG=white
# BULLETTRAIN_TIME_FG=black

# Contect (Annie@MBP)
BULLETTRAIN_CONTEXT_BG=white
BULLETTRAIN_CONTEXT_FG=black

# Exec Time
BULLETTRAIN_EXEC_TIME_BG=black
BULLETTRAIN_EXEC_TIME_FG=yellow

# 05/2025 workaround for bullet-train issue displaying git status
# https://github.com/ohmyzsh/ohmyzsh/issues/12328
zstyle ':omz:alpha:lib:git' async-prompt no 

# Time-last ordering
BULLETTRAIN_PROMPT_ORDER=(
  custom
  status
  context
  dir
  screen
  virtualenv
  nvm
  aws
  ruby
  go
  rust
  elixir
  hg
  perl
  git
  time
  cmd_exec_time
)

# "Agnoster"-like ordering (another theme) - Time first
# BULLETTRAIN_PROMPT_ORDER=(
#   time
#   context
#   dir
#   screen
#   virtualenv
#   nvm
#   aws
#   ruby
#   go
#   rust
#   elixir
#   hg
#   perl
#   git
#   status
#   cmd_exec_time
#   custom
# )


# ========================== 💫 Plugins =========================================
# 📁 Official plugins:          $ZSH/plugins/
# 📁 Custom user plugins:       $ZSH_CUSTOM/plugins/

#  - (!) Add wisely, as too many plugins slow down shell startup.
plugins=(
    themes
    # change ZSH theme from the shell

    zsh-interactive-cd
    # Provides an interactive way to change directories in zsh using fzf.
    # Usage:
    #    ⭐️ `cd ` + tab
    # Docs: https://github.com/mrjohannchang/zsh-interactive-cd 

    alias-finder
    # Makes learning new aliases easier.
    # Searches the defined aliases and outputs any that match the command inputted.
    # Docs: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder

    command-not-found
    # Suggested packages to be installed if a command cannot be found using
    # (command-not-found package for zsh).

    safe-paste
    # Prevents any code from actually running while pasting, so you have a chance
    # to review what was actually pasted before running it.

    copypath
    # Copies the path of given directory or file to the system clipboard.
    #  Usage:
    #   ⭐️ copypath                         copies the absolute path of the current dir.
    #   ⭐️ copypath <file_or_directory>     copies the absolute path of the given file.

    copyfile
    # Puts the contents of a file in your system clipboard so you can paste it anywhere.
    # Usage:  ⭐️ copyfile <filename>        copies the contents of the file named filename.
    
    web-search
    # Launch a websearch (in browser) from the terminal
    # Usage:
    #  ⭐️ web_search <context> <term> [more terms if you want]
    #  ⭐️ <context> <term> [more terms if you want]
    #  e.g.:     reddit test "search?" query
    #            google test search query
    #  Other contexts: ppai (perplexity ai), chatgpt, github, 
    # Context list: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search

     gitignore 
    # Use gitignore.io from the command line (requieres active internet connection).
    # Usage:
    #  ⭐️ gi list                list all the currently supported gitignore.io templates.
    #  ⭐️ gi [TEMPLATENAME]      show git-ignore output on the command line.
    #  ⭐️ gi [TEMPLATENAME] >> .gitignore
        # Append programming language settings to your projects .gitignore.


    ### Aliases
    common-aliases
    brew
    git
    )


# Plugs I don't need yet, but will!
# tldr --> https://github.com/tldr-pages/tldr, https://tldr.sh/ 
#       see also: competing projects - def need a cheat sheet tho
# tldr # adds `tldr` to front of the command you are typing (but haven't sent)
# man  # adds `man` to front of the command you are typing (but haven't sent)
# autoenv - automatically activate virtual environments
# git-commit - styler for commits - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-commit
# jsontools - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jsontools
# macos - for iTerm - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
# pip - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
# pipenv - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pipenv 
# ssh - provides hostname completion based off your ssh config
# dirhistory - adds keyboard shortcuts for navigating directory history and hierarchy
#              https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
# 

# ========================= 🔌 Plugin Settings ==================================
zstyle ':omz:plugins:alias-finder' autoload yes


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


# ========================= 🥊 Custom Functions =================================

## 🎨 Test out Terminal Themes (distinct from OMZ themes):
# Uncomment when deciding between multiple terminal colors!
# terminal_profile=$(osascript -e 'tell application "Terminal" to get name of current settings of front window')
# echo; neofetch    # 🍏🌈
# for color in black white red green yellow blue magenta cyan; do
#   print -P "%B%F{$color}$terminal_profile%f%b %F{$color} $color $color $color $color $color $color%f"
# done

## 🎨 Test out Terminal Themes (distinct from OMZ themes):
# Uncomment when deciding between multiple terminal colors!
testcolor(){
    terminal_profile=$(osascript -e 'tell application "Terminal" to get name of current settings of front window')
    echo; neofetch --block_width 4 --memory_percent on 
    for color in black red green yellow blue magenta cyan white; do
        print -P "%B%F{$color}$terminal_profile%f%b %F{$color} $color $color $color $color $color $color%f"
    done
}
alias colortest="testcolor"  # because I kept misremembering the name 50/50!

# ______________________________________________________________________________
