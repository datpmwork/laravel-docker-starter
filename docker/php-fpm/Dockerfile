FROM php:7.1-fpm

RUN docker-php-ext-install mysqli

RUN apt-get update && apt-get install -y libmcrypt-dev \
    mysql-client libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install mcrypt pdo_mysql

ADD ./laravel.ini /usr/local/etc/php/conf.d

WORKDIR /var/www/

# Install Composer Dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Tools
RUN apt-get install nano

CMD ["php-fpm"]

EXPOSE 9000