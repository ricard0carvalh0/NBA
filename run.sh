#!/bin/bash

build(){
    docker-compose build --no-cache --memory 4g --progress=plain;
}

up(){
    docker-compose up -d;
}

stop(){
    docker-compose down;
}

drop(){
    docker-compose down;
}

restart(){
    docker-compose down && docker-compose up -d
}

drop_hard(){
    docker-compose down --volumes --remove-orphans --rmi all;
    # docker stop $(docker ps -aq);
    docker builder prune --all --force;
    sudo rm -rf ./postgresdb/data ./postgresdb/log;
    # docker rm $(docker ps -aq);
    # docker rmi -f $(docker images -aq);
    # docker volume rm $(docker volume ls -q);
    sudo rm -rf ./maquina2/data ./maquina2/log;
    # docker network rm $(docker network ls -q | grep -vE '^(bridge|host|none)$');
}

cpKeys(){
    # Limpa entradas antigas no known_hosts
    docker exec -u postgres postgresdb bash -c "ssh-keygen -R maquina2 || true"
    docker exec -u postgres maquina2 bash -c "ssh-keygen -R postgresdb || true"

    # Remove antigas chaves privadas e públicas
    docker exec -u postgres postgresdb bash -c 'rm /var/lib/postgresql/.ssh/id_*'
    docker exec -u postgres maquina2 bash -c 'rm /var/lib/postgresql/.ssh/id_*'

    # Gera novas chaves
    docker exec -u postgres postgresdb ssh-keygen -t ed25519 -f /var/lib/postgresql/.ssh/id_ed25519 -N '' -q
    docker exec -u postgres maquina2 ssh-keygen -t ed25519 -f /var/lib/postgresql/.ssh/id_ed25519 -N '' -q

    # Captura as chaves públicas
    postgresdb_PUB="$(docker exec -u postgres postgresdb cat /var/lib/postgresql/.ssh/id_ed25519.pub)"
    MAQUINA2_PUB="$(docker exec -u postgres maquina2 cat /var/lib/postgresql/.ssh/id_ed25519.pub)"

    # Atualiza o authorized_keys de cada um
    docker exec -u postgres postgresdb bash -c "echo '$MAQUINA2_PUB' > /var/lib/postgresql/.ssh/authorized_keys"
    docker exec -u postgres maquina2 bash -c "echo '$postgresdb_PUB' > /var/lib/postgresql/.ssh/authorized_keys"
    docker exec -u postgres postgresdb bash -c "echo '$postgresdb_PUB' >> /var/lib/postgresql/.ssh/authorized_keys"
    docker exec -u postgres maquina2 bash -c "echo '$MAQUINA2_PUB' >> /var/lib/postgresql/.ssh/authorized_keys"

    # Permissões
    docker exec -u root postgresdb bash -c 'chown -R postgres:postgres /var/lib/postgresql/.ssh'
    docker exec -u root maquina2 bash -c 'chown -R postgres:postgres /var/lib/postgresql/.ssh'
    docker exec -u root postgresdb bash -c 'chmod 700 /var/lib/postgresql/.ssh'
    docker exec -u root maquina2 bash -c 'chmod 700 /var/lib/postgresql/.ssh'
    docker exec -u root postgresdb bash -c 'chmod 600 /var/lib/postgresql/.ssh/*'
    docker exec -u root maquina2 bash -c 'chmod 600 /var/lib/postgresql/.ssh/*'

    # Testar conexão
    docker exec -u postgres postgresdb ssh -o StrictHostKeyChecking=no maquina2 true || echo "Conexão falhou da postgresdb para a maquina2"
    docker exec -u postgres maquina2 ssh -o StrictHostKeyChecking=no postgresdb true || echo "Conexão falhou da maquina2 para a postgresdb"    
}

bashMaquina2(){
    docker-compose exec -u postgres maquina2 bash
}

bashpostgresdb(){
    docker-compose exec -u postgres postgresdb bash
}

$1
