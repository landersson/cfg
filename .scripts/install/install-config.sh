
#~/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CUR_DIR=`pwd`
TMP_DIR=$(mktemp -d)
echo "Work dir: $TMP_DIR"
trap '{ rm -rf "$TMP_DIR"; cd $CUR_DIR; }' EXIT
cd $TMP_DIR

#if [[ `cat /etc/issue | cut -f1 -d" "` == "Ubuntu" ]]; then
    #. $HOME/.scripts/install/ubuntu.sh
#fi





# Install VIM plugins

vim -f --not-a-term +PlugInstall +qall << END
:q
END


# Install tmux plugin manager

TPM_DIR=$HOME/.tmux/plugins/tpm
if [ -d $TPM_DIR ]; then
    echo "Directory $TPM_DIR already exists... attempting update"
    if ! git -C $TPM_DIR pull; then
        echo "Failed to update git repo $TPM_DIR. Ignoring."
    fi
else
    git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

echo "Configuration Installation Complete..."

