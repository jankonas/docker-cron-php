FROM php:8-fpm
COPY --chown=www-data:www-data app /var/www
WORKDIR /var/www
RUN rm -rf /var/www/html
RUN chmod +x /var/www/cron/deserialize-args.sh
