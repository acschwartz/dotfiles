# -------------------------------------------------
#  .INCOMPLETE. WIP .
# Beginnings of a New Machine setup script.
# Keeping a note in Apple Notes to document MY process.
# Building script as I go, in the order tasks are done.
# ---------------------------------------------------

# Step 0:
# [x] Download browsers (Chrome, etc)
#   FYI - chrome can be installed via homebrew!
#   ⭐️ see examples here: https://catalins.tech/how-i-setup-new-macbooks/
#   ⭐️ good example for how to structure scripts - https://github.com/sheharyarn/dotfiles/  
# [x] Download Bitwarden s*cret manager
# [x] Set up Bitwarden browser extensions (including TouchID authentication)
# ---------------------------------------------------

# [[TODO]] FUN FACT! Bitwarden has a CLI
# Wonder if that would have been helpful with certain tasks?
# [Currently it is not installed]

# ---------------------------------------------------


# Begin Script ....

# ---------------------------------------------------
#!/bin/bash
cd ~
# ---------------------------------------------------

# [[ TODO ]] be sure this is the right 'shebang' #!
# "#!/bin/bash" vs "#!/usr/bin/bash" vs "#!/usr/bin/env bash"

# ---------------------------------------------------

# [x] Install XCode Command Line Tools
sudo xcode-select --install

# ---------------------------------------------------

# [x] Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# FYI - Unsure what to do with curl exactly yet (in this script)
# Read https://www.joyfulbikeshedding.com/blog/2020-05-11-best-practices-when-using-curl-in-shell-scripts.html

# ---------------------------------------------------

# [ ] Import zsh settings, profile, plugs, etc.
# [[ TODO ]]  - yet to actually do

# ---------------------------------------------------

# [x] Install Homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ---------------------------------------------------

# [x] Generate SSH keys (id_ed25519)
# [x] for GitHub.com

# [[ TODO ]] - learn if this is necessary for this specific script, if any outside work needs done
# This was a pain in the ass and required a lot of troubleshooting in an attempt to add it to my Keychain (but it is in my keychain now)
# Instructions https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# See also: ~/.ssh/config
# [x] Add github as host to ssh config file.
# Perhaps this config is portable?

# ---------------------------------------------------

# [x] GitHub.com Config
# I won't have to do this part again - just import!

# ---------------------------------------------------

# [x] Download VSCode
brew install visual-studio-code
# TODO: reinstall VSCode extensions

# ---------------------------------------------------

# [x] (SOME) MacOS Settings
# macOS provides the `defaults`` utility to customize the settings of your MacBook and certain applications

# Enable tap-to-click for the trackpad and show the correct state in System Preferences
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

# Disable the .DS file creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Finder: Show hidden files
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

# Finder: Show the path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Finder: Show full path as window title  (vs. just folder name)
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true 

# Finder: Keep folders on top
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Desktop: Keep folders on top
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"

killall Finder

# Apply the settings
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u