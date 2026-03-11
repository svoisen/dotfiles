# DOT DOT DOT

## What is it?

These are the various configuration files I use to set up a macOS system
to my personal preference. Included are configuration files for zsh, vim, git
and other dotfile configurable utilities.

Feel free to peruse and cherry-pick what works for you.

## Installation on macOS

### Prerequisites

1. Homebrew
2. Node.js

### Install Dependencies

1. Install Alacritty: `brew install alacritty`
2. Install latest vim: `brew install vim`
3. Install fzf: `brew install fzf`
4. Install ripgrep: `brew install ripgrep`
5. Install tmux: `brew install tmux`
6. Install eza: `brew install eza`
7. [Install oh-my-zsh](https://ohmyz.sh/#install)
8. Install diff-so-fancy: `brew install diff-so-fancy`
9. Install Powerline fonts from https://github.com/powerline/fonts
10. Install custom oh-my-zsh plugins by cloning into `~/.oh-my-zsh/custom/plugins`:
    1. [forgit](https://github.com/wfxr/forgit)
    2. [zsh-eza](https://github.com/z-shell/zsh-eza)

### Install Dotfiles Using Dotbro

1. Install go if not already installed: `brew install golang`
2. Ensure go binaries are in your `$PATH`.
3. Install dotbro: `go install github.com/hypnoglow/dotbro@latest`
4. Install dotfiles `dotbro --config [PATH_TO_CONFIG_TOML]`

## Post-installation

1. Run `vim` to auto-install plugins as well as coc extensions.
2. In `tmux`, run the command `prefix + I` to install tmux plugins.
