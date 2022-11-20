#!/bin/zsh
cd $(readlink -f $(dirname $0))/.. || return
docker build --tag chiyoi/illustor3 .