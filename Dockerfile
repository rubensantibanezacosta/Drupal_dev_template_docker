FROM php:8.1-apache


## Install system dependencies
RUN apt-get update  && apt-get install -y \
                libmagickwand-dev \
                libfreetype6-dev \
                libpng-dev \
                libwebp-dev \
                libjpeg62-turbo-dev \
            gettext-base \
                libmcrypt-dev \
                libzip-dev \
            libpq-dev \
            zip \
                git \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pdo_mysql \
    gd \
    zip \
    && a2enmod \
    rewrite

  RUN pecl install imagick \
    && docker-php-ext-enable imagick

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Add the user UID:1000, GID:1000, home at /app
RUN groupadd -r app -g 1000 && useradd -u 1000 -r -g app -m -d /app -s /sbin/nologin -c "App user" app && \
   chmod 777 -R /app

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY . /app/
COPY default.conf /etc/apache2/sites-enabled/000-default.conf


WORKDIR /app


ENV COMPOSER_ALLOW_SUPERUSER=1

RUN composer install --no-ansi --no-dev --no-interaction --no-progress --optimize-autoloader --no-scripts
RUN composer require  drush/drush

RUN composer update


RUN chmod 777 /app/vendor/bin/drush




#entry point modification
COPY extra_modules.txt /extra_modules.txt
RUN chmod 777 /extra_modules.txt
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
RUN while read line; do echo "./vendor/bin/drush en $line -y;" >> /entrypoint.sh; echo "./vendor/bin/drush updatedb -y;" >> /entrypoint.sh; done < /extra_modules.txt
RUN sed -i '1d' /usr/local/bin/docker-php-entrypoint
RUN cat /usr/local/bin/docker-php-entrypoint > /tempcontent
RUN > /usr/local/bin/docker-php-entrypoint
RUN cat /entrypoint.sh >> /usr/local/bin/docker-php-entrypoint
RUN cat /tempcontent >> /usr/local/bin/docker-php-entrypoint

EXPOSE 80

