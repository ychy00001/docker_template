FROM php:7.2.11-fpm-alpine3.8

USER root

# 设置工作目录
WORKDIR /

ENV LANG C.UTF-8

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \ 
    # 安装composer
    && apk add wget \
    && wget https://getcomposer.org/download/1.5.1/composer.phar \
    && mv composer.phar /usr/bin/composer \
    && chmod 755 /usr/bin/composer \
    && apk add git \
    && apk add openssh \
    # 安装redis扩展
    && mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/3.0.0.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis \
    # 安装pdo_mysql扩展
    && /usr/local/bin/docker-php-ext-install pdo_mysql \
    # 安装前端环境
    && apk add npm \
    # 清理apk缓存
    && rm -rf /var/cache/apk/*


#安装kafka
ENV LIBRDKAFKA_VERSION v0.11.6

ENV BUILD_DEPS \
  autoconf \
        bash \
        build-base \
        git \
        pcre-dev \
        python
		
COPY ./librdkafka /tmp/librdkafka
COPY ./rdkafka-3.0.5.tgz /tmp/rdkafka-3.0.5.tgz

RUN apk --no-cache --virtual .build-deps add ${BUILD_DEPS} \
    && apk add librdkafka-dev \
    && cd /tmp \
    && pecl install rdkafka-3.0.5.tgz \
    && /usr/local/bin/docker-php-ext-enable rdkafka \
    && apk del .build-deps