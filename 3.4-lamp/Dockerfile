FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    apache2 \
    mariadb-server \
    php \
    libapache2-mod-php \
    php-mysql \
    wordpress \
    nano \
    && apt clean

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY wordpress.conf /etc/apache2/sites-available/wordpress.conf
COPY config-localhost.php /etc/wordpress/config-localhost.php

RUN a2ensite wordpress && a2enmod rewrite

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]
