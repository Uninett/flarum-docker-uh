FROM php:5.6-fpm

MAINTAINER Andreas Åkre Solberg <andreas@solweb.no>
MAINTAINER Simon Skrødal <simon.skrodal@uninett.no>

# install the PHP extensions we need
RUN apt-get update \
    && apt-get install -y libpng12-dev libjpeg-dev pwgen python-setuptools curl git unzip wget git nginx nano \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli opcache zip mbstring pdo_mysql

#COPY app /app
RUN mkdir /app
# VOLUME ["/app"]
WORKDIR "/app"

RUN bash -c "wget http://getcomposer.org/composer.phar && mv composer.phar /usr/local/bin/composer"
RUN chmod a+x /usr/local/bin/composer
RUN /usr/local/bin/composer create-project flarum/flarum . --stability=beta

RUN chmod -R a+rX .

# Supervisor Config
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout

# nginx config
#RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
#RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY etc/nginx-site.conf /etc/nginx/sites-available/default
COPY etc/supervisord.conf /etc/supervisord.conf
#COPY ./php-fpm.conf /usr/local/etc/php-fpm.conf

#COPY assets /app/assets

RUN chmod 777 /app
# RUN chmod -R 777 /app/assets
# RUN chmod -R 777 /app/extensions
# RUN chmod -R 777 /app/storage

COPY etc/config.php /app/config.php

COPY ./start.sh /start.sh
RUN chmod 755 /start.sh

#VOLUME ["/app/extensions/auth-dataporten"]
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]