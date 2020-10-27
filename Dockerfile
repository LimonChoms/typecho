FROM php:fpm-alpine
LABEL maintainer="limonchoms@outlook.com"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mcrypt opcache pdo_mysql exif gd zip && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && sed -i 's/405:100/999:999/g' /etc/passwd && sed -i 's/82:82/99:100/g' /etc/passwd
    
ENTRYPOINT ["php-fpm"]