# DOT DOT DOT

## What is it?

These are the various configuration files I use to set up a POSIX-style system
to my personal preference. Included are configuration files for zsh, vim, git 
and other dotfile configurable utilities.

Feel free to peruse and cherry-pick what works for you.

## Installation on macOS

### Install and Setup iTerm

1. Install iterm: `brew install iterm`

### Install Dependencies

1. Install latest vim: `brew install vim`
2. Install fzf: `brew install fzf`
3. Install ripgrep: `brew install ripgrep`
4. Install tmux: `brew install tmux`
5. Install exa: `brew install exa`
6. [Install oh-my-zsh](https://ohmyz.sh/#install)
7. Install diff-so-fancy: `brew install diff-so-fancy`
8. Install Powerline fonts from https://github.com/powerline/fonts
9. Install custom oh-my-zsh plugins by cloning into `~/.oh-my-zsh/custom/plugins`:
    1. [forgit](https://github.com/wfxr/forgit)
    2. [zsh-nvm](https://github.com/lukechilds/zsh-nvm)
    3. [zsh-aliases-exa](https://github.com/DarrinTisdale/zsh-aliases-exa)
    3. [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)

### Install Dotfiles Using Dotbro

1. Install go if not already installed: `brew install golang`
2. Ensure go binaries are in the `$PATH`.
3. Install dotbro: `go install github.com/hypnoglow/dotbro@latest`
4. Install dotfiles `dotbro --config [PATH_TO_CONFIG_TOML]`
