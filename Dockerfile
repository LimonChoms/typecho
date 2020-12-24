FROM php:7.4-fpm-alpine
LABEL maintainer="limonchoms@outlook.com"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mcrypt opcache pdo_mysql exif gd zip && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
    && rm -rf /var/cache/apk/* \
    && sed -i 's/405:100/999:1000/g' /etc/passwd && sed -i 's/82:82/99:100/g' /etc/passwd \
    && sed -i 's/100/1000/g' /etc/group && sed -i 's/82/100/g' /etc/group
    
ENTRYPOINT ["php-fpm"]
