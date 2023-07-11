#!/bin/bash

if ! [ -f "/root/.ottershell" ]; then
	mkdir /root/.ottershell
fi

CONF_FNAME=/root/.ottershell/ottershell.conf
if ! [ -f "$CONF_FNAME" ]; then
	cp /var/www/html/.ottershell/ottershell.conf "$CONF_FNAME"
fi

AONYEX_CONF_FNAME=/var/www/html/src/config/config.json
if ! [ -f "$AONYEX_CONF_FNAME" ]; then
	cp /var/www/html/.dockerize/aonyex/example-config.json "$AONYEX_CONF_FNAME"
fi

if ! [ -f "/var/www/html/ottershelld" ]; then
	wget https://aonyex.africa/binaries/debian/ottershelld -P /var/www/html
	chmod 755 /var/www/html/ottershelld
fi

if ! [ -f "/var/www/html/ottershell-cli" ]; then
	wget https://aonyex.africa/binaries/debian/ottershell-cli -P /var/www/html
	chmod 755 /var/www/html/ottershell-cli
fi

/var/www/html/ottershelld &
cron
a2enmod headers rewrite
apache2-foreground
