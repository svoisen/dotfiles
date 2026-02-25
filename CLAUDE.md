# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal macOS dotfiles managed with [dotbro](https://github.com/hypnoglow/dotbro). Files in this repo are symlinked to their target locations on the filesystem via `config.toml`.

## Deploying Dotfiles

```bash
# Install dotbro first (requires Go)
go install github.com/hypnoglow/dotbro@latest

# Deploy all dotfiles
dotbro --config ~/src/dotfiles/config.toml
```

The `config.toml` at the repo root defines all symlink mappings from repo paths to destination paths (relative to `$HOME`).

## Repository Structure

Each directory corresponds to a tool's configuration:

- `alacritty/` — Alacritty terminal config (`alacritty.toml`, catppuccin-macchiato theme via gruvbox fallback)
- `bin/` — Custom shell scripts symlinked to `~/bin`
- `git/` — Git config (`gitconfig`, `gitignore_global`); uses `diff-so-fancy` as pager
- `nvim/` — Neovim config (`init.lua`); uses lazy.nvim
- `tmux/` — Tmux config (`tmux.conf`, `tmuxline.conf`)
- `vim/` — Vim config (`vimrc`, `coc-settings.json`)
- `zsh/` — Zsh config (`zshrc`); uses oh-my-zsh + spaceship prompt

## Neovim Architecture

`nvim/init.lua` is a single-file config using [lazy.nvim](https://github.com/folke/lazy.nvim). Key plugin setup:

- **Colorscheme**: Catppuccin (macchiato flavor)
- **LSP**: nvim-lspconfig with gopls (Go), julials (Julia)
- **Completion**: nvim-cmp with sources: Copilot, LSP, LuaSnip, buffer, path, conjure
- **Fuzzy finding**: Telescope with fzf-native extension
- **File tree**: nvim-tree (`<leader>t`)
- **AI**: GitHub Copilot + CopilotChat (`<leader>cc`)
- **Clojure**: Conjure (nREPL), vim-jack-in, vim-sexp
- **Go**: vim-go plugin
- **Writing**: vim-pencil (auto-enabled for markdown/text with soft wrap + spellcheck)

Leader key is `<Space>`. Tmux/nvim pane navigation is unified via `nvim-tmux-navigation` (Ctrl+h/j/k/l).

## Zsh Setup

Uses oh-my-zsh with plugins: `tmux vi-mode common-aliases git zsh-eza`. The spaceship prompt is sourced from Homebrew. NVM is lazy-loaded. Julia is managed via juliaup.

Notable aliases: `cat` → `bat`, `python` → `python3`. FZF uses ripgrep as the default command.

## Post-Install Steps

After deploying:
1. Open `nvim` — lazy.nvim auto-bootstraps; run `:Lazy` to check plugin status
2. Open `tmux` — run `prefix + I` to install tmux plugins (via tpm)
3. Run `vim` — auto-installs coc extensions
