#!/bin/bash

# fixing www.conf for PHP-fpm port used
sed -i 's|PHP_PORT|'${PHP_PORT}'|g' /etc/php/7.3/fpm/pool.d/www.conf

# sleeping 10 seconds for mysqld to launch
sleep 10


if [ -f "/var/www/html/wordpress/wp-config.php" ]
then
	echo "Wordpress already confiured."
else
	# download wordpress-cli
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	# download wordpress
	wp core download --allow-root --path=${WP_PATH}

	# install wordpress
	wp core install --url=${DOMAIN_NAME} \
		--title=${WORDPRESS_TITLE} \
		--admin_user=${WORDPRESS_ADMIN_USER} \
		--admin_password=${WORDPRESS_ADMIN_PASSWORD} \
		--path=${WP_PATH} \
		--skip-email --allow-root

	# create databse
	wp config create --dbname=${MYSQL_DATABASE} \
		--dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} \
		--dbhost=${MYSQL_DB_HOST} \
		--path=${WP_PATH} \
		--skip-check \
		--allow-root

	# create user
	wp user create ${WORDPRESS_USER} \
		${WORDPRESS_EMAIL} \
		--role=author \
		--user_pass=${WORDPRESS_PASSWORD} \
		--path=${WP_PATH} \
		--allow-root

	# install theme
	wp theme install twentytwentyone \
		--activate \
		--path=${WP_PATH} \
		--allow-root

fi


PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

# start php-fpm
/usr/sbin/php-fpm$PHP_VERSION -F
