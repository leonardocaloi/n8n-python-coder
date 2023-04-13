#!/bin/bash

# Crie o usuário caloi
useradd -u $N8N_CODER_PUID -G $PGID $N8N_CODER_USER

# Defina a senha do usuário caloi
echo "${N8N_CODER_USER}:${N8N_CODER_PASS}" | chpasswd

# Altere as permissões do diretório python_dir
chown -R "$N8N_CODER_PUID":"$N8N_CODER_PGID" "/home/$CODER_USER/python_dir"

# Instale as extensões
/app/code-server/bin/code-server --install-extension ms-python.python --extensions-dir /config/extensions
/app/code-server/bin/code-server --install-extension dracula-theme.theme-dracula --extensions-dir /app/code-server/lib/vscode/extensions/

# Instale os pacotes necessários
apt update -y && apt install -y python3-pip python3-venv
apt clean && rm -rf /var/lib/apt/lists

# Crie e ative o ambiente virtual
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
