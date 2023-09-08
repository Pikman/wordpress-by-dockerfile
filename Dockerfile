FROM ubuntu:22.10

# LAMP
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
apache2 \
ghostscript \
libapache2-mod-php \
mysql-server \
php \
php-bcmath \
php-curl \
php-imagick \
php-intl \
php-json \
php-mbstring \
php-mysql \
php-xml \
php-zip \
unzip

# copy files
ADD https://wordpress.org/latest.tar.gz /var/www
RUN tar -xzvf /var/www/latest.zip && \  
    chown -R www-data:root /var/www/

# apache
COPY apache.conf /etc/apache2/sites-available/wordpress.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    ln -s /etc/apache2/sites-available/wordpress.conf /etc/apache2/sites-enabled/ \
    a2dissite 000-default

COPY wp-config.php /var/www/wordpress/wp-config.php
EXPOSE 80  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
