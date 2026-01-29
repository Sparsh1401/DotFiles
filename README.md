# Dotfiles

My personal dotfiles for macOS development environment.

## Quick Start (Fresh Mac)

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run setup script
cd ~/dotfiles && ./setup.sh
```

## Contents

| Directory | Description |
|-----------|-------------|
| `zshrc/` | Zsh config with Powerlevel10k, oh-my-zsh, fzf |
| `nvim/` | Neovim config (LazyVim-based) |
| `tmux/` | Tmux with Dracula theme, vim navigation |
| `ghostty/` | Ghostty terminal config |
| `git/` | Git config with aliases |
| `ideavim/` | IdeaVim for JetBrains IDEs |
| `vscode/` | VS Code / Cursor settings |
| `zed/` | Zed editor settings |
| `lazygit/` | Lazygit config (Catppuccin theme) |
| `wezterm/` | WezTerm terminal config |
| `karabiner/` | Karabiner keyboard customization |
| `zellij/` | Zellij multiplexer config |
| `k9s/` | Kubernetes CLI config |
| `starship/` | Starship prompt config |
| `skhd/` | macOS hotkey daemon |
| `homebrew/` | Brewfile with all packages |

## Manual Installation

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install packages
```bash
brew bundle --file=~/dotfiles/homebrew/Brewfile
```

### 3. Symlink with stow
```bash
cd ~/dotfiles
stow zshrc nvim tmux ghostty git ideavim zed
```

### 4. VS Code / Cursor (manual copy)
```bash
cp ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/
cp ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/
```

## Key Features

### Neovim (LazyVim)
- Tokyo Night theme with transparency
- Harpoon for quick file navigation
- DAP for Go debugging
- OpenCode AI integration
- Tmux/Vim seamless navigation
- LeetCode, WakaTime plugins

### Tmux
- Dracula theme with powerline
- Prefix: `Ctrl-a`
- Session persistence (resurrect/continuum)
- Vim-style pane navigation

### Zsh
- Powerlevel10k theme
- Oh-My-Zsh with git plugin
- `ga` - create git worktree clone
- `gd` - delete git clone with safety checks
- fzf integration

### VS Code / Cursor
- Vim mode with custom keybindings
- Dracula theme
- Fira Code font with ligatures
- Prettier formatting

## Backup Reminder

Before formatting, backup these separately (NOT in git):

```
~/.ssh/                    # SSH keys
~/.gnupg/                  # GPG keys
~/.wakatime.cfg           # WakaTime API key
~/.config/gcloud/         # GCloud credentials
~/grindOnly/.gitconfig-personal  # Personal git config
```

## Post-Setup Checklist

- [ ] Restore SSH keys and set permissions: `chmod 600 ~/.ssh/id_*`
- [ ] Run `tmux` and press `prefix + I` to install plugins
- [ ] Open `nvim` and let lazy.nvim install plugins
- [ ] Login to GitHub: `gh auth login`
- [ ] Login to GCloud: `gcloud auth login`
- [ ] Configure WakaTime API key
