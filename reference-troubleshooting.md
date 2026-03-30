# 📓 Reference: Troubleshooting Log

## Stow Silently Failing on MacOS (Fixed)

### Overview

Problem fixed. Troubleshooting steps for future reference.

#### Problem

- ❌ On macOS, `stow` appeared to work on dotfiles, but actually failed to create a symlink

#### Diagnosis

- 👉 System Integrity Protection (SIP) was quietly preventing the operation

#### Solution

- ❗️ Must explicitly set `--target=~` to bypass SIP when linking SIP-protected files
  - Even though `stow whatever` defaults to home folder as target, SIP blocks the operation
    - Setting the target *explicitly* is the fix
- ✅ Created `.stowrc` and added `--target=~` so you don’t have to type it every time

#### Note

- ⚠️ Stow fails silently when SIP blocks it — verbosity has no effect.
- Stow works *as expected* with most files, even when the home folder is used as the default target & not explicitly invoked (tested & confirmed). It's specifically dotfiles/configs that are protected by the operating system in this case.

### Troubleshooting Details

#### Terminal Commands

- `ll file` (alias for `ls -l file`)
  - list file info, long version
- `ln -s ~/dev/dotfiles/git/.gitconfig ~/.gitconfig`
  - create symlink (manually)
- `dtruss`
  - 'see what Stow is actually doing under the hood'

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

- ✅ Using GNU Stow (2.4.1).
- ✅ $HOME is correctly set to /Users/annie.
- ✅ Manual symlinking works as expected.
- ✅ Stow believes it’s creating the link (LINK: .gitconfig => dotfiles/git/.gitconfig).
- ❌ After running Stow, the symlink does not appear.
- ❗️ `dtrace` identifies Stow failed due to System Integrity Protection
