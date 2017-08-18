## If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return;
fi

## history
HISTSIZE=100000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%F %T '
## share history
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'

## C-d によるログアウト入力を防止（100回までは無視する）
IGNOREEOF=100

## Load shell scripts
if [ -d "${HOME}/.bash.d" ] ; then
    # clear generated cmds
    rm -f $HOME/.bash.d/gen_cmd/* > /dev/null 2>&1

    . $HOME/.bash.d/lib/init.sh
    for f in "${HOME}"/.bash.d/source/*.sh ; do
        . "$f"
    done
    unset f
    echo == Loaded scripts under .bash.d/ ==
fi

if which direnv > /dev/null; then
    eval "$(direnv hook bash)"
fi

## Remove duplicates in PATH
pathctl_uniq

## Load temporary settings
load_or_create $HOME/.bash.d/local/bashrc.sh

if [ "$(uname)" == 'Darwin' ] || [ "$(uname)" == 'FreeBSD' ]; then
    ls_cmd='gls'
    alias ps='ps aux'
elif [ "$(uname)" == 'Linux' ]; then
    ls_cmd='ls'
    alias ps='ps auxf'
fi

## alias
alias dc='docker-compose'
alias df='df -h'
alias diff='git diff'
alias dm='docker-machine'
alias dps='docker ps -a'
alias drm='docker rm $(docker ps -f status=exited -q)'
alias dstat='dstat -Tclmdrn'
alias ekill='emacsclient -e "(kill-emacs)"'
alias emacs='emacsclient -t'
alias gh='hg plog $(hg slog | peco | awk "{print \$1}")'
alias hg='$HOME/.bash.d/cmd_alias/hg'
alias l='$ls_cmd --color=auto --group-directories-first'
alias ll='l -ahl --time-style long-iso'
alias pip='$HOME/.bash.d/cmd_alias/pip'
alias repo='cd $(ghq list -p | peco)'
alias s='ssh $(grep -h "^Host" ~/.ssh/config | peco | awk "{print \$2}")'
alias tm='tmux a'

## bind
bind -x '"\C-r": peco_history'
bind -x '"\C-xj": pcd'

## prompt
PROMPT_DIRTRIM=2
PS1="[\h@\w\$(_branch)]\$ "
