#!/bin/bash

# Dotfiles Setup Script
# Run this on a fresh Mac to set up your development environment

set -e

echo "Setting up your Mac development environment..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# Install packages from Brewfile
echo "Installing Homebrew packages..."
brew bundle --file=~/dotfiles/homebrew/Brewfile

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Stow dotfiles
echo "Symlinking dotfiles with stow..."
cd ~/dotfiles

# Remove existing files that would conflict
rm -f ~/.zshrc ~/.p10k.zsh ~/.tmux.conf ~/.gitconfig ~/.ideavimrc 2>/dev/null || true
rm -rf ~/.config/nvim ~/.config/ghostty ~/.config/zed 2>/dev/null || true

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Stow each configuration
stow zshrc
stow nvim
stow tmux
stow ghostty
stow git
stow ideavim
stow zed

# VS Code settings (manual copy, not stow)
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
    echo "Setting up VS Code..."
    cp ~/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
    cp ~/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
fi

# Cursor settings (manual copy)
if [ -d "$HOME/Library/Application Support/Cursor/User" ]; then
    echo "Setting up Cursor..."
    cp ~/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Cursor/User/settings.json"
    cp ~/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Cursor/User/keybindings.json"
fi

# Lazygit settings (manual copy)
echo "Setting up Lazygit..."
mkdir -p "$HOME/Library/Application Support/lazygit"
cp ~/dotfiles/lazygit/config.yml "$HOME/Library/Application Support/lazygit/config.yml"

echo ""
echo "Setup complete! Please:"
echo "1. Restart your terminal"
echo "2. Run 'tmux' and press prefix + I to install tmux plugins"
echo "3. Open nvim and let lazy.nvim install plugins"
echo ""
echo "Don't forget to:"
echo "- Restore your SSH keys from backup"
echo "- Login to your accounts (GitHub, etc.)"
echo "- Run 'p10k configure' if you want to customize your prompt"
