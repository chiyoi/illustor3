#!/bin/zsh
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

source $root/.venv/bin/activate

pip freeze > requirements.txt