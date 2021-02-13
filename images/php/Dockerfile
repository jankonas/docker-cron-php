FROM php:8-fpm
RUN rm -rf /usr/local/etc/php-fpm.d
COPY conf /usr/local/etc/php-fpm.d
EXPOSE 9001

COPY --chown=www-data:www-data app /var/www
WORKDIR /var/www
RUN rm -rf /var/www/html

RUN chmod +x /var/www/cron/deserialize-args.sh
