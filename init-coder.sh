#!/bin/bash

# shellcheck disable=SC2046
usermod -l "$CODER_USER" $(getent passwd "$PUID" | cut -d: -f1)

chown -R "$PUID":"$PGID" "/home/$CODER_USER/python_dir"

/app/code-server/bin/code-server --install-extension ms-python.python --extensions-dir /config/extensions
/app/code-server/bin/code-server --install-extension dracula-theme.theme-dracula --extensions-dir /app/code-server/lib/vscode/extensions/

apt update -y && apt install -y python3-pip
apt install -y python3-venv
apt clean && rm -rf /var/lib/apt/lists

mkdir -p "/home/$CODER_USER/python_dir/venv/"
cd "/home/$CODER_USER/python_dir" && python3 -m venv venv/

"$PWD/venv/bin/python" -m pip install ipykernel -U --force-reinstall

source "$PWD/venv/bin/activate"
sudo -u $CODER_USER pip3 install --upgrade pip
sudo -u $CODER_USER pip3 install -r "/home/$CODER_USER/python_dir/requirements.txt"

