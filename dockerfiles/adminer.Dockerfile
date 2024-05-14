FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories &&\
    apk update && \
    apk upgrade && \
    apk add --no-cache php81 \
    php81 php81-fpm \ 
    php81-opcache \
    php81-json \
    php81-openssl \
    php81-curl \
    php81-zip \
    php81-mbstring \
    php81-phar \
    php81-iconv \
    php81-ctype \
    php81-session \
    php81-tokenizer \
    php81-xml \
    php81-pgsql \
    php81-pdo_pgsql



# Create a symbolic link for the php executable
RUN ln -s /usr/bin/php81 /usr/bin/php

# install adminer dans /var/www/html/
RUN wget -q -O ./adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php/

# # Set the working directory
WORKDIR /var/www/html

# WORKDIR /srv
EXPOSE 80

# CMD php -S 0.0.0.0:8080 -t /var/www/html
CMD php -S 0.0.0.0:8080 