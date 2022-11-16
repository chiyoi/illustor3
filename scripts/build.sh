#!/bin/zsh
root=$(readlink -f $(dirname $0)/..)
cd $root

rm -rf target || return $?
mkdir target || return $?

cp -r src target/app || return $?
cp -r weights target || return $?
cp api.py config.py target || return $?