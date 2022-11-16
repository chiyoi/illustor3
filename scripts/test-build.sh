#!/bin/zsh
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

rm -rf target || return $?
mkdir target || return $?

cp api.py config.py target || return $?
cp -r src target || return $?
cp -r weights target || return $?