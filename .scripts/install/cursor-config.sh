
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ `uname -s` == "Darwin" ]]; then
    CONFIG_DIR=~/Library/Application\ Support/
elif [[ `uname -s` == "Linux" ]]; then
    CONFIG_DIR=~/.config/
else
    echo "Unsupported OS"
    exit 1
fi

CURSOR_DIR=${CONFIG_DIR}/Cursor/User/

if ! test -L ${CURSOR_DIR}/settings.json; then
    mv ${CURSOR_DIR}/settings.json ${CURSOR_DIR}/settings.json.bak
fi
if ! test -L ${CURSOR_DIR}/keybindings.json; then
    mv ${CURSOR_DIR}/keybindings.json ${CURSOR_DIR}/keybindings.json.bak
fi

ln -fs ~/.config/cursor/settings.json ${CURSOR_DIR}/settings.json
ln -fs ~/.config/cursor/keybindings.json ${CURSOR_DIR}/keybindings.json
