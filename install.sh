#!/bin/bash
export $(grep -v '^#' .env | xargs)
docker-compose down
docker-compose build
docker-compose up -d
docker cp ./python/. code-server:"/config/workspace/python_dir"

docker cp ./oh-my-zsh.sh code-server:"/config/workspace/oh-my-zsh.sh"
docker exec code-server /bin/bash -c "chmod +x /config/workspace/oh-my-zsh.sh && /config/workspace/oh-my-zsh.sh"
docker exec -u root code-server /bin/bash -c "usermod -s $(which zsh) abc"

docker cp ./python_env.sh code-server:"/config/workspace/python_env.sh"
docker exec code-server usr/bin/zsh -c "chmod +x /config/workspace/python_env.sh && /config/workspace/python_env.sh"
docker exec code-server usr/bin/zsh -c "mkdir /config/.cache/oh-my-zsh && mkdir /config/.cache/oh-my-zsh/completions"
