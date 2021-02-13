#!/usr/bin/env sh

SCRIPT_FILENAME=/var/www/cron/entrypoint.php REQUEST_METHOD=GET CRON_RUNNER_SERIALIZED_ARGS=$(serialize-args "$@") cgi-fcgi -bind -connect php:9001
