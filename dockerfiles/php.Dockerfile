FROM alpine:latest

# Enable the testing repository
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Update and install packages
RUN apk update && \
    apk upgrade && \
    apk add --no-cache tini php81 php81-fpm php81-opcache php81-mysqli php81-pdo_mysql php81-json php81-openssl php81-curl php81-ctype php81-session php81-tokenizer php81-pgsql php81-pgsql php81-pdo_pgsql libpq-dev
    
# Copier le fichier de configuration PHP
# COPY php.ini /etc/php81/conf.d/

# Create a symbolic link for the php executable
RUN ln -s /usr/bin/php81 /usr/bin/php

# Run PHP-FPM
CMD ["/usr/sbin/php-fpm81", "-R", "--nodaemonize"]