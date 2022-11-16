#!/bin/zsh
if test $# -ne 1; then
    echo "usage: test.sh \033[4mtest-file\033[0m"
    return 1
fi
root=$(readlink -f $(dirname $0)/..)
cd $root || return $?

test_file=$(readlink -f $1)
target=$root/target
export PYTHONPATH=$target:$target/app:$PYTHONPATH
cd $target || return $?

python $test_file
