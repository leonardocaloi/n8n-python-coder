#!/bin/bash

# shellcheck disable=SC2046
usermod -l "$CODER_USER" $(getent passwd "$PUID" | cut -d: -f1)

# Create N8N_CODER_USER
useradd -u $N8N_CODER_PUID -g $N8N_CODER_PGID -m $N8N_CODER_USER

# Set password for N8N_CODER_USER
echo "$N8N_CODER_USER:$N8N_CODER_PASS" | chpasswd

chown -R "$PUID":"$PGID" "/home/$CODER_USER/python_dir"

/app/code-server/bin/code-server --install-extension ms-python.python --extensions-dir /config/extensions
/app/code-server/bin/code-server --install-extension dracula-theme.theme-dracula --extensions-dir /app/code-server/lib/vscode/extensions/

apt update -y && apt install -y python3-pip
apt install -y python3-venv
apt clean && rm -rf /var/lib/apt/lists

mkdir -p "/home/$N8N_CODER_USER/python_dir/venv/"
cd "/home/$N8N_CODER_USER/python_dir" && python3 -m venv venv/

"$PWD/venv/bin/python" -m pip install ipykernel -U --force-reinstall

source "$PWD/venv/bin/activate"
sudo -u $N8N_CODER_USER pip3 install --upgrade pip
sudo -u $N8N_CODER_USER pip3 install -r "/home/$N8N_CODER_USER/python_dir/requirements.txt"

# Copie o arquivo requirements.txt para o diretório do usuário
cp /home/$N8N_CODER_USER/python_dir/requirements.txt /home/$N8N_CODER_USER/

# Ative o ambiente virtual e instale os pacotes
/bin/bash -c "source /home/$N8N_CODER_USER/python_dir/venv/bin/activate && \
    pip install -r /home/$N8N_CODER_USER/requirements.txt"

# Remova o arquivo requirements.txt copiado
rm /home/$N8N_CODER_USER/requirements.txt
