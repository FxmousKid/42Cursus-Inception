FROM debian:buster

RUN apt update -y && \
	apt-get upgrade -y && \
	apt-get install -y php \
	php-mysql \
	php-cli \
	curl \
	php-mbstring \
	php-fpm \
	php-gettext \
	mariadb-client \
	wget && \
	rm -rf /etc/php/7.3/fpm/pool.d/www.conf && \
	mkdir -p /run/php

COPY ./tools/entrypoint.sh .
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
RUN chmod +x ./entrypoint.sh


CMD ["./entrypoint.sh"]