<?php

declare(strict_types = 1);

$command = [
	escapeshellcmd(__DIR__ . '/deserialize-args.sh'),
	escapeshellarg($_SERVER['CRON_RUNNER_SERIALIZED_ARGS']),
	escapeshellarg('php'),
	escapeshellarg(__DIR__ . '/../scripts/console.php'),
];

exec(implode(' ', $command), $output);
echo implode(PHP_EOL, $output);
