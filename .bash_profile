#
# 環境変数を設定
#

## color of ls
# export CLICOLOR=1
# export LSCOLORS=DxGxcxdxCxegedabagacad

## PATH
export LANG=ja_JP.UTF-8
export ALTERNATE_EDITOR=""
export EDITOR='emacsclient -t'
export PATH=$HOME/.cask/bin:$PATH
# export PATH=$HOME/.bash.d/cmd:$PATH

test -r ~/.bashrc && . ~/.bashrc
