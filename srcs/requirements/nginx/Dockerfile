FROM	debian:buster

RUN	    apt update -y && \
	    apt upgrade -y && \
	    apt-get install -y nginx \
        openssl && \
        mkdir -p /etc/nginx/ssl && \
        mkdir -p /run/nginx && \
        chown -R www-data /var/lib/nginx && \
        rm -rf /etc/nginx/sites-available/default

COPY    ./conf/default.conf /etc/nginx/sites-available/default.conf
COPY    ./conf/default.conf /etc/nginx/default.conf
COPY    ./tools/entrypoint.sh /tmp/entrypoint.sh

RUN     ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

EXPOSE	443

ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]
