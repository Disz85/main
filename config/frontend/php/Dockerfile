FROM phpdockerio/php:8.1-fpm
WORKDIR "/application"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php8.1-mysqlnd php8.1-redis php8.1-imagick \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
