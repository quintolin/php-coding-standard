<?php

declare(strict_types=1);

use PhpCsFixer\Config;
use PhpCsFixer\Finder;
use Quintolin\CodingStandard\PhpCsFixerRulesFactory;

// manually load factory class to avoid requiring `composer install`
require_once __DIR__ . '/src/PhpCsFixerRulesFactory.php';

$factory = new PhpCsFixerRulesFactory();
$rules = $factory->create();

$finder = Finder::create();
$finder->files();
$finder->in(dirs: __DIR__);
$finder->append(iterator: [__FILE__]);

$config = new Config(name: 'Quintolin');
$config->setFinder(finder: $finder);
$config->setRiskyAllowed(isRiskyAllowed: true);
$config->setRules(rules: $rules);

return $config;
