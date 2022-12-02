cd $(readlink -f $(dirname $0))/.. || return
source ./.venv/bin/activate
scr build-test || return
cd target || return

dir=$(readlink -f .)
export PYTHONPATH=$dir:$dir/internal:$PYTHONPATH

uvicorn illustor3-server:mux