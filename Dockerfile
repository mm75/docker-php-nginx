FROM debian

MAINTAINER Jackson Veroneze <jackson@jacksonveroneze.com>

ENV DEBIAN_FRONTEND noninteractive

RUN export TERM=xterm \
    && export XDEBUG_CONFIG="idekey=dbgp" \
    && echo "export TERM=xterm" >> /root/.bashrc \
    && echo "export XDEBUG_CONFIG=\"idekey=dbgp\"" >> /root/.bashrc \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
    curl \
    git \
    nginx \
    net-tools \
    nano \
    php5-dev \
    php5-cli \
    php5-intl \
    php-soap \
    php5-json \
    php5-curl \
    php5-fpm \
    php-pear \
    php5-gd \
    php5-pgsql \
    php5-mysql \
    php5-mcrypt \
    php5-memcached \
    php5-memcache \
    php5-xdebug \
    php5-ldap \
    php5-imagick \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean

RUN sed -i "s/;date.timezone =/date.timezone = America\/Sao_Paulo/" /etc/php5/cli/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = America\/Sao_Paulo/" /etc/php5/fpm/php.ini \
    && sed -i "s/short_open_tag = On/short_open_tag = Off/" /etc/php5/cli/php.ini \
    && sed -i "s/short_open_tag = On/short_open_tag = Off/" /etc/php5/fpm/php.ini \
    && sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/" /etc/php5/cli/php.ini \
    && sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/" /etc/php5/fpm/php.ini \
    && sed -i "s/display_errors = Off/display_errors = On/" /etc/php5/cli/php.ini \
    && sed -i "s/display_errors = Off/display_errors = On/" /etc/php5/fpm/php.ini \
    && sed -i "s/display_startup_errors = Off/display_startup_errors = On/" /etc/php5/cli/php.ini \
    && sed -i "s/display_startup_errors = Off/display_startup_errors = On/" /etc/php5/fpm/php.ini \
    && sed -i "s/log_errors = Off/log_errors = On/" /etc/php5/cli/php.ini \
    && sed -i "s/log_errors = Off/log_errors = On/" /etc/php5/fpm/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 5000M/" /etc/php5/cli/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 5000M/" /etc/php5/fpm/php.ini \
    && sed -i "s/post_max_size = 8M/post_max_size = 5000M/" /etc/php5/cli/php.ini \
    && sed -i "s/post_max_size = 8M/post_max_size = 5000M/" /etc/php5/fpm/php.ini \
    && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini \
    && sed -i "s/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 0.0.0.0/" /etc/php5/fpm/pool.d/www.conf

RUN adduser --disabled-password --gecos '' www \
    && rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default \
    && mkdir /etc/nginx/ssl/

ADD default /etc/nginx/sites-available/

ADD xdebug.ini /etc/php5/mods-available

ADD nginx.crt /etc/nginx/ssl/

ADD nginx.key /etc/nginx/ssl/

RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
    && php5enmod dev

EXPOSE 80 443
