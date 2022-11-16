#!/bin/zsh
if test $# -ne 1; then
    echo "usage: test.sh \033[4mtest-file\033[0m"
    return 1
fi
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

./script/build.sh || return $?

source $root/.venv/bin/activate

test_file=$(readlink -f $1)
target=$root/target
export PYTHONPATH=$target:$target/src:$PYTHONPATH
cd $target || return $?

python $test_file
