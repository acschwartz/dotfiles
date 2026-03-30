
# ==============================================================================
# =            🪄 Zsh Profile   (.zprofile - Login Shell Config)               =
# ==============================================================================

# ========================= 📝 Notes ============================================
# .zprofile     run once at login
# .zshrc        run every time you open a new tab/window

# On macOS, Terminal apps launch your shell as a login shell by default
# which means both .zprofile and .zshrc run.
# ______________________________________________________________________________

## .zprofile (login shell config):
#   Used for setting environment variables that need to be initialized
#   once per login session.
#
#   Examples:
#     - Adding Homebrew and VS Code paths so your system “knows” about
#       those tools during the whole session. (PATH is where the shell
#       looks for executables when you type a command.)
#     - Variables related to locale (LANG), or things that affect the
#       whole user environment at login.
#     - These settings affect all shells and GUI apps launched after login.
#     - Loaded once when you log in,
#       e.g., opening Terminal app, logging in via SSH.
# ______________________________________________________________________________

# ==============================================================================
# =                           🧙‍♂️ Config                                        =
# ==============================================================================

## 🐚 User Shell Scripts
# User shell scripts go in the `~/bin` folder
# This allows them to be used from any directory in your user account
export PATH="~/bin:$PATH"

## 🍺 Homebrew (brew)
# Set up Homebrew environment (Apple Silicon installs to /opt/homebrew)
#   - adds Homebrew’s binary directory to PATH
#   - sets up Homebrew's env vars & makes them available to your shell
#      - e.g. HOMEBREW_PREFIX, HOMEBREW_CELLAR, HOMEBREW_REPOSITORY
# Ensures `brew` and software installed through it available
eval "$(/opt/homebrew/bin/brew shellenv)"

## 🧬 VSCode (code)
# Add the Visual Studio Code (code) CLI binary to $PATH
# This lets you launch VS Code from the terminal using the `code` command
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# ______________________________________________________________________________
