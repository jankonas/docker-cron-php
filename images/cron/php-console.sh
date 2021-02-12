#!/usr/bin/env sh

SCRIPT_FILENAME=/var/www/cron/entrypoint.php REQUEST_METHOD=GET PHP_CONSOLE_COMMAND="$1" PHP_CONSOLE_PARAM="$2" cgi-fcgi -bind -connect php:9000
