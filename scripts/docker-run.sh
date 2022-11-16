#!/bin/zsh
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

docker stop illustor3
docker rm illustor3
docker run --name illustor3 -p 8000:8000 -d chiyoi/illustor3