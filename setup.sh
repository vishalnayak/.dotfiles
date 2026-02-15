#!/bin/bash

set -e

echo "🚀 Starting fresh environment setup..."

# Helper: Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Install High-Performance Toolchain
TOOLS=(zsh neovim starship zoxide fzf ripgrep fd bat eza tmux go golangci-lint gh)

for tool in "${TOOLS[@]}"; do
    if ! command_exists "$tool"; then
        echo "Installing $tool..."
        brew install "$tool"
    else
        echo "✔ $tool is already installed."
    fi
done

# 2. Create Configuration Directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config/starship

# 3. Aggressive Symbolic Link Logic
DOTFILES_SRC=$(pwd)

link_file() {
    local src="$1"
    local dest="$2"
    
    # If it's already a link to the right place, do nothing
    if [ -L "$dest" ] && [ "$(readlink "$dest")" == "$src" ]; then
        echo "✔ $dest is already correctly linked."
        return
    fi
    
    # If any file/link exists, back it up
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing $dest to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
    
    ln -s "$src" "$dest"
    echo "✅ Linked $dest"
}

# Run linking
link_file "$DOTFILES_SRC/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_SRC/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_SRC/starship.toml" "$HOME/.config/starship/starship.toml"
link_file "$DOTFILES_SRC/init.lua" "$HOME/.config/nvim/init.lua"
link_file "$DOTFILES_SRC/.vimrc" "$HOME/.vimrc"

# 4. Finalizing
echo "✨ Setup Complete! Run 'source ~/.zshrc' to refresh your session."
