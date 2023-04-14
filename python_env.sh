#!/bin/bash

# shellcheck disable=SC2046
usermod -l "$CODER_USER" $(getent passwd "$PUID" | cut -d: -f1)

chown -R "$PUID":"$PGID" "$HOME/workspace/python_dir"

/app/code-server/bin/code-server --install-extension ms-python.python --extensions-dir /config/extensions
/app/code-server/bin/code-server --install-extension dracula-theme.theme-dracula --extensions-dir /app/code-server/lib/vscode/extensions/

apt update -y && apt install -y python3-pip
apt clean && rm -rf /var/lib/apt/lists

# pip install --upgrade pip
# pip install -r "$HOME/workspace/python_dir/requirements.txt"

"/bin/python3" -m pip install ipykernel -U --force-reinstall
sudo -u $CODER_USER pip3 install --upgrade pip
sudo -u $CODER_USER pip3 install -r "$HOME/workspace/python_dir/requirements.txt"

