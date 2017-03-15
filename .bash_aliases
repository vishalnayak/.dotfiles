# Add the following three lines to ~/.bash_profile
# Load all the common aliases
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# Those which does not take parameters
alias ls="ls -a"
alias gs="git status"
alias ga="git add -u ."
alias gb="git branch -vv"
alias gdh="git diff HEAD^"
alias gl="git log"
alias vishal="cd $GOPATH/src/github.com/vishalnayak/"
alias vsh="cd $GOPATH/src/github.com/hashicorp/vault-ssh-helper"
alias vsd="vault server -dev -dev-root-token-id root"
alias gov="cd $GOPATH/src/github.com/hashicorp/vault"
alias gon="cd $GOPATH/src/github.com/hashicorp/nomad"
alias goc="cd $GOPATH/src/github.com/hashicorp/consul"
alias ta="tmux attach"
alias md="time make dev"
alias mt="time make test > results.txt 2>&1"
alias tailr="tail -f results.txt"
alias vsf="rm -rf filedata/ && vault server -config vaultfilebackend.hcl"
alias vinit="vault init -key-shares 1 -key-threshold 1"

# Those which takes parameters

gp () {
        git push -u origin $1
}

gd () {
        git diff $1
}

gdc () {
        git diff --cached $1
}

gc () {
        git commit -m $1
}

cl () {
  git add CHANGELOG.md;
  git commit -m "changelog++";
}

pr () {
  git fetch oss pull/$1/head:pr-$1 && git checkout pr-$1;
}
