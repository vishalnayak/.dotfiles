# Path exports
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:$HOME/.local/bin

# Initialize Starship Prompt
eval "$(starship init zsh)"

# Initialize Zoxide (Better directory navigation)
eval "$(zoxide init zsh)"

# Initialize FZF (Fuzzy Finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color='hl:161,hl+:161,fg+:15,bg+:238,hl+:161'"

# Modern CLI Aliases
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --git'
alias la='eza -a --icons'
alias tree='eza --tree --icons'
alias cat='bat --paging=never'
alias find='fd'
alias grep='rg'
alias vim='nvim'
alias vi='nvim'

# Go Development shortcuts
alias gmt='go mod tidy'
alias gv='go verify'
alias gbuild='go build -v'
alias gtest='go test -v -race'

# Directory Listings
alias ls='eza -la --icons --git'

# Git Shortcuts
alias gs='git status'
alias gd='git diff'

# Open VS Code from terminal
alias code='/usr/local/bin/code'
# Principal PM shortcut: Open current project in VS Code
alias vsc='code .'



# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
