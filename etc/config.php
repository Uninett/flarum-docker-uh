<?php 


return array (
  'debug' => true,
  'database' => 
  array (
    'driver' => 'mysql',
    'host' => getenv('MYSQL_HOST'),
    'database' => getenv('MYSQL_DB'),
    'username' => getenv('MYSQL_USER'),
    'password' => getenv('MYSQL_PASSWD'),
    'charset' => 'utf8mb4',
    'collation' => 'utf8mb4_unicode_ci',
    'prefix' => '',
    'strict' => false,
  ),
  'url' => getenv('APPURL'),
  'paths' => 
  array (
    'api' => 'api',
    'admin' => 'admin',
  )
);