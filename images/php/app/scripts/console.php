<?php

declare(strict_types = 1);

if ($argc !== 3 || $argv[1] !== 'content:set') {
	echo sprintf('Usage: %s content:set <content>' . PHP_EOL, $argv[0]);
	exit(1);
}

file_put_contents(__DIR__ . '/../data/content.txt', $argv[2]);
