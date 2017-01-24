# Those which does not take parameters
alias gs="git status"
alias gb="git branch -vv"
alias gdh="git diff HEAD^"
alias gl="git log"
alias vsh="cd $GOPATH/src/github.com/hashicorp/vault-ssh-helper"
alias gov="cd $GOPATH/src/github.com/hashicorp/vault"
alias gon="cd $GOPATH/src/github.com/hashicorp/nomad"
alias goc="cd $GOPATH/src/github.com/hashicorp/consul"
alias ta="tmux attach"

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
        git checkout $1
}

cl () {
  git add CHANGELOG.md;
  git commit -m "changelog++";
}

pr () {
  git fetch oss pull/$1/head:pr-$1 && git checkout pr-$1;
}
