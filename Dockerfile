FROM ubuntu:22.10

# LAMP
RUN apt-get update 
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y \
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
php-zip

# copy files
ADD wordpress-6.1.1.tar.gz /var/www
RUN chown -R www-data:root /var/www/wordpress

# apache
COPY apache.conf /etc/apache2/sites-available/wordpress.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN ln -s /etc/apache2/sites-available/wordpress.conf /etc/apache2/sites-enabled/
RUN a2dissite 000-default

COPY wp-config.php /var/www/wordpress/wp-config.php
EXPOSE 80  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
# create db
# mysql -u root -p
# CREATE DATABASE wordpress;
# CREATE USER wordpress@localhost;
# GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost IDENTIFIED BY 'password';
# FLUSH PRIVILEGES;
# quit

# rename wp-config, fill in db-name
# cd /var/www/wordpress
# cp wp-config-sample.php wp-config.php
# RUN cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php \
# sed -i 's/database_name_here/wordpress/' /var/www/wordpress/wp-config.php \
# sed -i 's/username_here/wordpressuser@localhost/' /var/www/wordpress/wp-config.php \
# sed -i 's/password_here/password/' /var/www/wordpress/wp-config.php 

# // ** MySQL settings - You can get this info from your web host ** //
# /** The name of the database for WordPress *//
# define('DB_NAME', 'wordpress');
# /** MySQL database username */
# define('DB_USER', 'wordpressuser');
# /** MySQL database password */
# define('DB_PASSWORD', 'password');

