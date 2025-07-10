FROM zabbix/zabbix-server-pgsql:alpine-latest

USER root

RUN apk update && apk add --no-cache \
    unixodbc \
    unixodbc-dev \
    psqlodbc \
    && rm -rf /var/cache/apk/*

# Copia os arquivos de configuração ODBC
COPY odbcinst.ini /etc/odbcinst.ini
COPY odbc.ini /etc/odbc.ini

RUN mkdir -p /etc/unixODBC && \
    ln -sf /etc/odbc.ini /etc/unixODBC/odbc.ini && \
    ln -sf /etc/odbcinst.ini /etc/unixODBC/odbcinst.ini

