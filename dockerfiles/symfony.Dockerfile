FROM alpine:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update && apk add --no-cache curl php81 php81-curl php81-json php81-phar php81-openssl php81-iconv php81-mbstring bash tini

RUN curl -sS https://getcomposer.org/installer | php81 -- --install-dir=/usr/bin --filename=composer

RUN apk update && apk add --no-cache bash

COPY symfony-stable_alpine.sh /tmp/symfony-stable_alpine.sh

RUN chmod +x /tmp/symfony-stable_alpine.sh

RUN /bin/bash /tmp/symfony-stable_alpine.sh

RUN apk add symfony-cli

WORKDIR /var/www/html

RUN mkdir -p /var/log && chmod 777 /var/log

ADD rootfs /

ENTRYPOINT ["/sbin/tini", "--"]

EXPOSE 9000

WORKDIR /var/www

RUN ln -s /usr/sbin/php-fpm81 /usr/sbin/php-fpm

CMD ["/usr/sbin/php-fpm", "-R", "--nodaemonize"]