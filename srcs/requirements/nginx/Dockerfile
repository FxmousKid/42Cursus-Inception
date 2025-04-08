FROM	debian:buster

RUN	    apt update -y && \
	    apt upgrade -y && \
	    apt-get install -y nginx \
        openssl && \
        mkdir -p /etc/nginx/ssl && \
        mkdir -p /run/nginx && \
        chown -R www-data /var/lib/nginx &&\
        rm -rf /etc/nginx/sites-available/default


COPY ./conf/default.conf /etc/nginx/sites-available/default.conf
COPY ./conf/default.conf /etc/nginx/default.conf
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN rm -f /etc/nginx/sites-enabled/default

# Create symbolic link
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default

EXPOSE	80

ENTRYPOINT [ "sh", "/tmp/entrypoint.sh" ]
