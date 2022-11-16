#!/bin/zsh
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

./scripts/build.sh || return $?

source $root/.venv/bin/activate

target=$root/target
export PYTHONPATH=$target:$target/src:$PYTHONPATH
cd $target || return $?

uvicorn api:mux