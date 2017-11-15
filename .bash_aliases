# Add the following three lines to ~/.bash_profile
# Load all the common aliases
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# Those which does not take parameters
NOTIFIER=" && terminal-notifier -message \"Completed. Success!\" -sound Ping || terminal-notifier -message \"Completed. Failed!\" -sound Basso"
alias ls="ls -l"
alias gs="git status"
alias ga="git add -u ."
alias gb="git branch -vv"
alias gdh="git diff HEAD^"
alias gl="git log"
alias vishal="cd $GOPATH/src/github.com/vishalnayak/"
alias vsh="cd $GOPATH/src/github.com/hashicorp/vault-ssh-helper"
alias vsd="vault server -dev -dev-root-token-id root -log-level=trace -dev-plugin-dir=plugin-dir"
alias vrd="VAULT_REDIRECT_ADDR=http://127.0.0.1:8200 vault server -log-level=debug -dev -dev-root-token-id=root -dev-ha -dev-transactional"
alias vrd2="VAULT_REDIRECT_ADDR=http://127.0.0.1:8202 vault server -log-level=debug -dev -dev-root-token-id=root -dev-listen-address=127.0.0.1:8202 -dev-ha -dev-transactional"
alias repem="vault write -f sys/replication/primary/enable; vault write -field wrapping_token sys/replication/primary/secondary-token id=asdf | vault2 write sys/replication/secondary/enable token=-"
alias gov="cd $GOPATH/src/github.com/hashicorp/vault"
alias gon="cd $GOPATH/src/github.com/hashicorp/nomad"
alias goc="cd $GOPATH/src/github.com/hashicorp/consul"
alias ta="tmux attach"
alias md="time make dev"$NOTIFIER
alias mt="time make test > results.txt 2>&1"$NOTIFIER
alias tailr="tail -f results.txt"
alias vsf="rm -rf filedata/ && vault server -config vaultfilebackend.hcl"
alias vinit="vault init -key-shares 1 -key-threshold 1"
alias camfix="sudo killall VDCAssistant"

vault2 () {
  VAULT_ADDR=http://127.0.0.1:8202 vault $@
}

vault3 () {
  VAULT_ADDR=http://127.0.0.1:8204 vault $@
}

mtp () {
	time make test TEST=$1 TESTARGS="-v" > results.txt 2>&1 && terminal-notifier -message "Completed. Success!" -sound Ping || terminal-notifier -message "Completed. Failed!" -sound Basso
}

mtpr () {
	time make test TEST=$1 TESTARGS="-v -run $2" > results.txt 2>&1 && terminal-notifier -message "Completed. Success!" -sound Ping || terminal-notifier -message "Completed. Failed!" -sound Basso
}

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

epr () {
  git fetch ent pull/$1/head:pr-$1 && git checkout epr-$1;
}
