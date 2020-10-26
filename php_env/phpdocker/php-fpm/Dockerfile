FROM phpdockerio/php7-fpm:latest
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install php-pear php-dev php-bcmath php-mysql php-redis php-bz2 php-gd php-imagick php-intl php-soap php-xdebug \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install ext-mongodb
RUN pecl install mongodb 
RUN echo 'extension=mongodb.so' > /etc/php/7.0/cli/conf.d/20-mongodb.ini

# Install git
RUN apt-get update \
    && apt-get -y install git \
    wget \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer