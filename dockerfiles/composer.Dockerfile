FROM alpine:3.17

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update && apk add --no-cache curl php81 php81-curl php81-json php81-phar php81-openssl php81-iconv php81-mbstring

RUN curl -sS https://getcomposer.org/installer | php81 -- --install-dir=/usr/local/bin --filename=composer

# Create a symbolic link for the php executable
RUN ln -s /usr/bin/php81 /usr/bin/php

CMD ["/usr/local/bin/composer"]