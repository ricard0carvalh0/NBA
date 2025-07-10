FROM postgres:17
WORKDIR /var/lib/postgresql
#test
RUN rm -rf /var/lib/postgresql/pgbackrest.conf

ENV PGDATA="/var/lib/postgresql/data"
ENV POSTGRES_PASSWORD="1234abc@"
ENV POSTGRES_INITDB_ARGS="--auth-host=scram-sha-256"
#ENV POSTGRES_DB="maquina1"
ENV TZ="America/Bahia"
ENV PGTZ="America/Bahia"
ENV PGPORT="5432"
ENV PGBACKREST_CONFIG="/etc/pgbackrest/pgbackrest.conf"

# Instala pacotes necessários
RUN mkdir -p /var/run/sshd /var/lib/postgresql/log /etc/pgbackrest /tmp/pgbackrest
RUN touch /var/lib/postgresql/log/postgresql-maquina1.log && chmod 777 -R /var/lib/postgresql/log
RUN apt-get update -y && apt-get install -y curl gnupg lsb-release sudo openssh-server pgbackrest gosu cron nano tzdata && rm -rf /var/lib/apt/lists/*

# Confs PGBackRest
RUN cat > /etc/pgbackrest/pgbackrest.conf <<EOF
[global]
repo1-path=/var/lib/pgbackrest
repo1-host=maquina2
repo1-host-user=postgres
log-level-console=info
log-level-file=debug
log-path=/var/lib/postgresql/log
compress-level=3
start-fast=y

[maquina1]
pg1-path=/var/lib/postgresql/data
pg1-port=5432
pg1-user=postgres
pg1-database=nba

EOF
RUN chmod 777 /etc/pgbackrest/pgbackrest.conf && chown postgres:postgres /etc/pgbackrest/pgbackrest.conf

RUN mkdir -p /var/lib/postgresql/.ssh \
    && chown -R postgres:postgres /var/lib/postgresql \
    && usermod -aG sudo postgres \
    && passwd -d postgres \
    && echo "postgres ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/postgres \
    && chmod 0440 /etc/sudoers.d/postgres \
    && gosu postgres ssh-keygen -t ed25519 -f /var/lib/postgresql/.ssh/id_ed25519 -N '' -q \
    && chown -R postgres:postgres /var/lib/postgresql \
    && chmod 700 /var/lib/postgresql/.ssh \
    && chmod 600 /var/lib/postgresql/.ssh/*

# Confs SSH
RUN passwd -d root && \
    echo "AuthorizedKeysFile .ssh/authorized_keys" >> /etc/ssh/sshd_config && \
    echo "Match User postgres" >> /etc/ssh/sshd_config && \
    echo "    PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "    PermitEmptyPasswords no" >> /etc/ssh/sshd_config && \
    echo "    AuthenticationMethods publickey" >> /etc/ssh/sshd_config && \
    sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?\(PubkeyAuthentication\).*$/\1 yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?\(AuthorizedKeysFile\).*$/\1 .ssh\/authorized_keys/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?\(StrictModes\).*$/\1 no/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Cria diretório para chaves SSH
RUN mkdir -p /var/lib/postgresql/.ssh && chmod 700 /var/lib/postgresql/.ssh
# Credenciais SSH
RUN cat > /var/lib/postgresql/.ssh/config <<EOF
Host maquina2
  HostName maquina2
  User postgres
  IdentityFile /var/lib/postgresql/.ssh/id_ed25519
  StrictHostKeyChecking no

EOF
RUN chmod 600 /var/lib/postgresql/.ssh/config && chown postgres:postgres /var/lib/postgresql/.ssh/config

# Entrypoint Custom
RUN cat > /usr/local/bin/docker-entrypoint-custom.sh <<EOF
#!/bin/bash
set -e

# Garantir arquivo de log
#mkdir -p /var/lib/postgresql/log && touch /var/lib/postgresql/log/postgresql-maquina1.log && chmod 777 -R /var/lib/postgresql/log

# Iniciar ssh server
/etc/init.d/ssh start

# Iniciar Posttgreql
/usr/local/bin/docker-entrypoint.sh postgres \
#-c logging_collector=on \
#-c log_directory='/var/lib/postgresql/log' \
#-c log_filename='postgresql-1.log' \
#-c log_statement='all' "\$@" &

# Garantir permissoes
chown -R postgres:postgres /var/lib/postgresql
chown -R postgres:postgres /var/lib/pgbackrest
chown -R postgres:postgres /tmp/pgbackrest

# Monitorar logs
#tail -f /var/lib/postgresql/log/postgresql-1.log

EOF

# RUN chmod +x /usr/local/bin/docker-entrypoint-custom.sh && chmod 0644 /var/lib/postgresql/crontab-agendar
RUN chown -R postgres:postgres /var/lib/postgresql && \
    chown -R postgres:postgres /var/lib/pgbackrest && \
    chown -R postgres:postgres /tmp/pgbackrest

USER root

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/docker-entrypoint-custom.sh" ]

