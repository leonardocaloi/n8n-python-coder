#!/bin/bash
export $(grep -v '^#' .env | xargs)
docker-compose down
docker-compose up -d
docker cp ./python/. code-server:"/home/${CODER_USER}/python_dir"
docker cp ./init-coder.sh code-server:"/home/${CODER_USER}/python_dir/init-coder.sh"
docker exec code-server /bin/bash -c "chmod +x /home/${CODER_USER}/python_dir/init-coder.sh && /home/${CODER_USER}/python_dir/init-coder.sh && rm /home/${CODER_USER}/python_dir/init-coder.sh"
