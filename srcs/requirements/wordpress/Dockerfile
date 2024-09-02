# the base image
FROM debian:buster

RUN apt-get update && \
	apt-get install -y php-fpm php-mysql curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf && \
	mkdir -p /run/php /var/www /var/log/php

COPY tools/conf.sh /usr/local/bin/wordpress_setup.sh
RUN chmod +x /usr/local/bin/wordpress_setup.sh

EXPOSE 9000

# this command will Specify the default command to run the WordPress setup script
CMD ["/usr/local/bin/wordpress_setup.sh"]
