#
# Temboard
#
FROM python:3.13.1-alpine3.21 AS temboard

ENV TZ="America/Bahia"
ENV TEMBOARD_SERVER_VERSION="9.0.1"

WORKDIR /home/temboard

RUN addgroup -g 1000 -S temboard \
    && adduser -h /home/temboard -u 1001 -G temboard -D temboard \
    && chown -R temboard:temboard /home/temboard

RUN apk update \
    && apk add --no-cache \
    openssl \
    bash \
    sudo \
    postgresql15-client \
    && passwd -d root

RUN pip install temboard==$TEMBOARD_SERVER_VERSION psycopg2-binary

RUN cat > /home/temboard/entrypoint.sh <<EOF
#!/bin/bash 
set -e

# temboard entrypoint
# Configure temboard
bash /usr/local/share/temboard/auto_configure.sh

# Migrate temboard database
export PGPASSWORD=\${TEMBOARD_PASSWORD}
[ ! -f databaseMigrated ] && bash /usr/local/share/temboard/create_repository.sh && touch databaseMigrated

# Run temboard
sudo -iu temboard temboard -c /etc/temboard/temboard.conf


EOF

RUN chmod +x /home/temboard/entrypoint.sh \
    && chown -R temboard:temboard /home/temboard

USER root
