#!/bin/bash

{
	sed -e "s%base_url_environment%$BASE_URL%g" -i /config.yaml
	sed -e "s/database_host_environment/$DB_HOST/g" -i /config.yaml
	sed -e "s/database_name_environment/$DB_NAME/g" -i /config.yaml
	sed -e "s/database_username_environment/$DB_UNAME/g" -i /config.yaml
	sed -e "s/database_password_environment/$DB_PW/g" -i /config.yaml
	sed -e "s/admin_username_environment/$ADMIN_UNAME/g" -i /config.yaml
	sed -e "s/admin_password_environment/$ADMIN_PW/g" -i /config.yaml
	sed -e "s/admin_pasword_conf_environment/$ADMIN_PW/g" -i /config.yaml
	sed -e "s/admin_mail_environment/$ADMIN_MAIL/g" -i /config.yaml
	sed -e "s/flarum_site_name_environment/$SITE_NAME/g" -i /config.yaml
	sed -e "s/dataporten_client_id_environment/$DATAPORTEN_CLIENTID/g" -i /config.yaml
	sed -e "s/dataporten_client_secret_environment/$DATAPORTEN_CLIENTSECRET/g" -i /config.yaml

	echo "Trying to install Flarum database"

	php -q flarum install -f /config.yaml
	rm /app/config.php
	mv /app/config.php_ /app/config.php
	php -q flarum migrate
	/usr/local/bin/supervisord -n

} || {
	echo "Database already exists"
	rm /app/config.php
	mv /app/config.php_ /app/config.php
	php -q flarum migrate
	/usr/local/bin/supervisord -n
}
