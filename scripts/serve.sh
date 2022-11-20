#!/bin/zsh
cd $(readlink -f $(dirname $0))/.. || return
source ./.venv/bin/activate
scr build-test || return
cd target || return

dir=$(readlink -f .)
export PYTHONPATH=$dir:$dir/pkg:$PYTHONPATH

uvicorn illustor3-server.server:mux