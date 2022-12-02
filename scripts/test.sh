usage='usage: test <pkg> <name>
    run the test like "python <pkg>/<name>_test.py
returns:
    0 - ok
    1 - usage error'

if test $# -ne 2; then
    echo $usage
    return 1
fi

cd $(readlink -f $(dirname $0))/.. || return
source ./.venv/bin/activate
scr build-test || return
cd target || return

dir=$(readlink -f .)

export PYTHONPATH=$dir:$dir/internal:$dir/internal/stylegan3:$PYTHONPATH

python "$1/${2}_test.py"
