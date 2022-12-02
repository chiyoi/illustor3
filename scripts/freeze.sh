cd $(readlink -f $(dirname $0))/.. || return
source ./.venv/bin/activate
pip freeze > requirements.txt