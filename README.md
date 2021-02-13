# Docker cron for php commands example

Example of how you can run php commands through some "console" entrypoint script via cron in containerized environment.

## Problem description

In modern PHP web applications, you usually have some command line entrypoint php script (something like `console.php`), which you use to run commands either by hand or from cron.

Setting up cron on regular server is pretty straightforward - you just run `crontab -e` end add something like this:

```crontab
* * * * *  php /path/to/console.php command [arguments...]
```

But what about containerized environment? You can of course add the crontab into the php image, but this is not best practise. One process per container they say...

## Running the example

Default configuration assumes you have port 80 free to be bound. If not, alter the docker-compose.yml file.

Fire it up through docker-compose:

```shell
docker-compose up --force-recreate
```

The `--force-recreate` option is here in case you are running the command repeatedly to always start with the default page.

Now open http://localhost/ in your browser. You should see the text `cron did not run`. If you wait for a minute and refresh the page, it should have a different content (`date` output from the cron run). 

After you are done, just press Ctrl+C and optionally remove the containers:

```shell
docker-compose down
```

## Altering the example

How to change this to make something more useful you ask?

Crontab settings are in [images/cron/crontab](images/cron/crontab). The command should always start with `php-console`.

The console script location is  [images/php/app/scripts/console.php](images/php/app/scripts/console.php).

If you want to move the console script elsewhere, you need to adjust it's location in [images/php/app/cron/entrypoint.php](images/php/app/cron/entrypoint.php) on line 9.

This `entrypoint.php` file is internal entrypoint responsible for passing arguments to the console script. If you want to move it too, you need to alter it's location in [images/cron/php-console.sh](images/cron/php-console.sh) and move the `deserialize-args.sh` file with it (don't forget to also alter the Dockerfile).

## How it works?

In the php container, there are two php-fpm pools spawned - one handles requests from webserver (`www` pool) and the second one handles cron commands (`cron` pool). They are listening on different ports (`www` on 9000 and `cron` on 9001).

The [images/php/app/cron/entrypoint.php](images/php/app/cron/entrypoint.php) script handles the cron commands by deserializing the arguments and passing them to the [images/php/app/scripts/console.php](images/php/app/scripts/console.php) script by invoking following command in cli (via exec function):

```shell
php /path/to/console.php [argument(s)]
```

> Side note: Since there are separate php-fpm pools for webserver and cron, you can still disable the `exec` function in the php.ini file (or elsewhere) if you override that in the cron pool configuration. 

In the cron container, [images/cron/php-console.sh](images/cron/php-console.sh) script is responsible for serializing arguments and making the request to php-fpm via FastCGI interface.

Security-wise the `cron` pool configuration will probably be more loose, so it is a good idea to restrict connections to it only from the cron container. You can easily do that via the `listen.allowed_clients` directive, but since it accepts only IPs and not hosts, determining the container IP depends on the runtime environment and is out of the scope of this example.  Another option for adding more security could be introducing shared secret between the cron container and the entrypoint script in the php container.

And that is pretty much it. If you have some concerns, ideas or improvements, feel free to open an issue.
