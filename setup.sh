#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting Nuclear Dotfiles Reset..."

# 1. Define Paths
DOTFILES_DIR=$(pwd)
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# 2. Cleanup Phase: Wipe the 'Bad State'
echo "🧹 Wiping cached Neovim state and broken links..."
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Remove old files/links to ensure fresh symlinks
rm -f ~/.vimrc
rm -f "$NVIM_CONFIG_DIR/init.lua"

# 3. Directory Preparation
mkdir -p "$NVIM_CONFIG_DIR"
mkdir -p ~/.vim/undo ~/.vim/backup ~/.vim/swap

# 4. Symbolic Link Phase
echo "🔗 Linking configuration files..."

# Force link the vibrant .vimrc
if [ -f "$DOTFILES_DIR/.vimrc" ]; then
    ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
    echo "✅ Linked .vimrc"
else
    echo "❌ Error: $DOTFILES_DIR/.vimrc not found!"
    exit 1
fi

# Force link the modern init.lua
if [ -f "$DOTFILES_DIR/init.lua" ]; then
    ln -sf "$DOTFILES_DIR/init.lua" "$NVIM_CONFIG_DIR/init.lua"
    echo "✅ Linked init.lua"
else
    echo "❌ Error: $DOTFILES_DIR/init.lua not found!"
    exit 1
fi

# 5. Toolchain Verification
echo "🛠 Checking for core tools..."
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure Neovim 0.11+ and Go tools are present
brew install neovim ripgrep fd gopls golangci-lint

# 6. Plugin Sync
echo "📦 Bootstrapping Neovim plugins..."
# This runs Neovim in the background to install Lazy.nvim and all plugins
nvim --headless "+Lazy! sync" +qa

echo "✨ Reset Complete! Launch Neovim to see your vibrant Go environment."
