#!/bin/zsh
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

docker build --tag chiyoi/illustor3 .