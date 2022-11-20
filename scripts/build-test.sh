#!/bin/zsh
cd $(readlink -f $(dirname $0))/.. || return
rm -rf ./target || return
mkdir ./target || return

cp config.py ./target || return
cp -r ./pkg ./target || return
cp -r ./weights ./target || return

cp -r ./cmd/illustor3-server ./target || return