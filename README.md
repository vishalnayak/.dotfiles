# Engineering Dotfiles

Standardized development environment for Go engineering.

## Setup
1. Clone the repository: `git clone https://github.com/vishalnayak/.dotfiles.git ~/dotfiles`
2. Run the installer: `cd ~/dotfiles && chmod +x setup.sh && ./setup.sh`

## Post-Install Steps
* Authenticate GitHub CLI: `gh auth login`
* Launch Neovim to sync plugins: `nvim`
* Refresh shell: `source ~/.zshrc`

## Included Tools
* Shell: Zsh + Starship
* Editor: Neovim + Native Go LSP
* Multiplexer: Tmux
* Modern CLI: eza, bat, ripgrep, fd, zoxide, fzf:wq

