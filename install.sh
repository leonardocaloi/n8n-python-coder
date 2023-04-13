#!/bin/bash
export $(grep -v '^#' .env | xargs)
docker-compose down
docker-compose up -d
docker cp ./python/. code-server:"/home/${N8N_CODER_USER}/python_dir"
docker cp ./init-coder.sh code-server:"/home/${N8N_CODER_USER}/python_dir/init-coder.sh"
docker exec code-server /bin/bash -c "chmod +x /home/${N8N_CODER_USER}/python_dir/init-coder.sh && /home/${N8N_CODER_USER}/python_dir/init-coder.sh && rm /home/${N8N_CODER_USER}/python_dir/init-coder.sh"
