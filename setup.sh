#!/bin/bash

set -e

echo "Starting idempotent environment modernization..."

# Helper: Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Ensure Homebrew is installed
if ! command_exists brew; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed. Skipping..."
fi

# 2. Install Core Utilities
TOOLS=(
    zsh neovim starship zoxide fzf ripgrep fd bat eza tmux go golangci-lint direnv
)

echo "Verifying toolchain..."
for tool in "${TOOLS[@]}"; do
    if ! command_exists "$tool"; then
        echo "Installing $tool..."
        brew install "$tool"
    else
        echo "$tool is already present."
    fi
done

# 3. Create Configuration Directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config/starship

# 4. Idempotent Symlink Protocol
DOTFILES_SRC=$(pwd)

link_file() {
    local src=$1
    local dest=$2

    # Check if the destination is already a symbolic link pointing to the correct source
    if [ -L "$dest" ]; then
        local current_src
        current_src=$(readlink "$dest")
        if [ "$current_src" == "$src" ]; then
            echo "Link for $dest is already correct. Skipping..."
            return
        fi
    fi

    # If file exists but is not the correct link, create a backup
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing $dest to ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
}

echo "Applying configuration links..."
link_file "$DOTFILES_SRC/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_SRC/.tmux.conf" "$HOME/.tmux.conf"
link_file "$DOTFILES_SRC/starship.toml" "$HOME/.config/starship/starship.toml"
link_file "$DOTFILES_SRC/init.lua" "$HOME/.config/nvim/init.lua"

# 5. Initialize Neovim Plugin Manager (Lazy.nvim)
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_PATH" ]; then
    echo "Installing Lazy.nvim..."
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_PATH"
else
    echo "Lazy.nvim already installed. Skipping..."
fi

# 6. Default Shell Update
if [[ "$SHELL" != */zsh ]]; then
    echo "Switching default shell to Zsh..."
    ZSH_PATH=$(which zsh)
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo "$ZSH_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$ZSH_PATH"
else
    echo "Default shell is already Zsh. Skipping..."
fi

echo "Environment check complete. Run 'source ~/.zshrc' to refresh your session."
