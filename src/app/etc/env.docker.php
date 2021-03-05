<?php
$env = [
    'install' => [
        'date' => 'Wed, 10 Oct 2018 09:52:12 +0000'
    ],
    'backend' => [
        'frontName' => getenv('ADMIN_URI')
    ],
    'crypt' => [
        'key' => getenv('KEY')
    ],
    'db' => [
        'table_prefix' => '',
        'connection' => [
            'default' => [
                'host' => getenv('DB_HOST'),
                'dbname' => getenv('DB_NAME'),
                'username' => getenv('DB_USER'),
                'password' => getenv('DB_PASS'),
                'model' => 'mysql4',
                'engine' => 'innodb',
                'initStatements' => 'SET NAMES utf8;',
                'active' => '1'
            ]
        ]
    ],
    'resource' => [
        'default_setup' => [
            'connection' => 'default'
        ]
    ],
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => getenv('MAGE_MODE'),
    'cache_types' => [
        'config' => 1,
        'layout' => 1,
        'block_html' => 1,
        'collections' => 1,
        'reflection' => 1,
        'db_ddl' => 1,
        'eav' => 1,
        'customer_notification' => 1,
        'config_integration' => 1,
        'config_integration_api' => 1,
        'full_page' => 1,
        'config_webservice' => 1,
        'translate' => 1,
        'compiled_config' => 1
    ],
    'directories' => [
        'document_root_is_pub' => true
    ]
];

if (getenv('REDIS_SESSION_HOST')) {
    $env['session'] = [
        'save' => 'redis',
        'redis' => [
            'host' => getenv('REDIS_SESSION_HOST'),
            'database' => '2',
            'max_concurrency' => '16',
        ]
    ];
}
if (getenv('REDIS_SESSION_PORT')) {
    $env['session']['redis']['port'] = getenv('REDIS_SESSION_PORT');
}
if (getenv('REDIS_SESSION_DB')) {
    $env['session']['redis']['database'] = getenv('REDIS_SESSION_DB');
}

if (getenv('REDIS_CACHE_HOST')) {
    $env['cache']['frontend']['default'] = [
        'backend' => 'Cm_Cache_Backend_Redis',
        'backend_options' => [
            'server' => getenv('REDIS_CACHE_HOST'),
            'database' => '0',
        ]
    ];
}
if (getenv('REDIS_CACHE_PORT')) {
    $env['cache']['frontend']['default']['backend_options']['port'] = getenv('REDIS_CACHE_PORT');
}
if (getenv('REDIS_CACHE_DB')) {
    $env['cache']['frontend']['default']['backend_options']['database'] = getenv('REDIS_CACHE_DB');
}

if (getenv('REDIS_FPC_HOST')) {
    $env['cache']['frontend']['page_cache'] = [
        'backend' => 'Cm_Cache_Backend_Redis',
        'backend_options' => [
            'server' => getenv('REDIS_FPC_HOST'),
            'database' => '1',
        ]
    ];
}
if (getenv('REDIS_FPC_PORT')) {
    $env['cache']['frontend']['page_cache']['backend_options']['port'] = getenv('REDIS_FPC_PORT');
}
if (getenv('REDIS_FPC_DB')) {
    $env['cache']['frontend']['page_cache']['backend_options']['database'] = getenv('REDIS_FPC_DB');
}

if (getenv('VARNISH_HOST')) {
    $env['http_cache_hosts'] = [
        [
            'host' => getenv('VARNISH_HOST'),
        ]
    ];
}
if (getenv('VARNISH_PORT')) {
    $env['http_cache_hosts'][0]['port'] = getenv('VARNISH_PORT');
}

return $env;
