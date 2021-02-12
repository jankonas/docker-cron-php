<?php

declare(strict_types = 1);

$command = [
	'php',
	escapeshellarg(__DIR__ . '/../scripts/console.php'),
	escapeshellarg($_SERVER['PHP_CONSOLE_COMMAND'])
];

if (isset($_SERVER['PHP_CONSOLE_PARAM'])) {
	$command[] = escapeshellarg($_SERVER['PHP_CONSOLE_PARAM']);
}

exec(implode(' ', $command), $output, $returnCode);

echo implode(PHP_EOL, $output);
exit($returnCode);
