# Modernized Engineering Dotfiles

This repository contains configurations and automation to establish a high-performance development environment optimized for Go-centric software engineering.

## Core Features

* **High-Performance Shell:** Zsh combined with Starship for a fast, context-aware prompt.
* **Modern Editor:** Neovim configured with native LSP for Go development (using gopls).
* **Rust-Based Toolchain:** Replaces legacy GNU utilities with faster alternatives (ripgrep, fd, eza, bat).
* **Efficient Navigation:** Zoxide for smart directory jumping and fzf for fuzzy search.

## Repository Structure

* `setup.sh`: Automated installation and symlinking script.
* `.zshrc`: Shell settings and high-productivity aliases.
* `.tmux.conf`: Terminal multiplexer config with Vim-style navigation.
* `config/starship.toml`: Prompt configuration.
* `config/nvim/init.lua`: Neovim entry point and plugin setup.
* `templates/`: Boilerplate files (Makefile, Dockerfile, golangci.yml) for Go projects.

## Installation

1. Clone this repository: `git clone https://github.com/vishalnayak/.dotfiles.git ~/dotfiles`
2. Enter the directory: `cd ~/dotfiles`
3. Run the setup: `chmod +x setup.sh && ./setup.sh`
