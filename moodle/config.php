<?php

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost = 'localhost';
$CFG->dbname = 'moodle';
$CFG->dbuser = 'root';
$CFG->dbpass = 'agora';
$CFG->prefix = 'mdl_';

$CFG->dboptions = [
    'dbpersist' => 0,
    'fetchbuffersize' => 0,
    'dbsocket' => 0,
    'dbport' => 3306,
];

$CFG->wwwroot = 'https://ioc-aws.xtec.cat';
$CFG->dirroot = '/dades/html';
$CFG->dataroot = '/dades/data/moodledata';
$CFG->directorypermissions = 00777;
#$CFG->alternateloginurl = 'https://ioc-aws.xtec.cat/educacio';
$CFG->cronclionly = false;
$CFG->admin = 'admin';

$CFG->session_handler_class = '\\core\\session\\redis';
$CFG->session_redis_host = '127.0.0.1';
$CFG->session_redis_port = 6379;
$CFG->session_redis_database = 0; // Optional, default is db 0.
$CFG->session_redis_auth = ''; // Optional, default is don't set one.
$CFG->session_redis_prefix = 'ioc_sess_'; // Optional, default is don't set one.
$CFG->session_redis_acquire_lock_timeout = 120;
$CFG->session_redis_acquire_lock_retry = 100; // Optional, default is 100ms (from 3.9)
$CFG->session_redis_lock_expire = 7200;
$CFG->session_redis_serializer_use_igbinary = false; // Optional, default is PHP builtin serializer

$CFG->local_redislock_redis_server = '127.0.0.1';
$CFG->lock_factory = '\\local_redislock\\lock\\redis_lock_factory';

$CFG->passwordsaltmain = 'abcdefghijklmnopqrstuvwxyz0123456789';
$CFG->localcachedir = '/dades/localdata/localcache';
$CFG->cachedir = '/dades/localdata/cache';

$CFG->zip = '/usr/bin/zip';
$CFG->unzip = '/usr/bin/unzip';
$CFG->pathtodu = '/usr/bin/du';

// LaTeX
$CFG->filter_tex_pathconvert = '/usr/bin/convert';
$CFG->filter_tex_pathdvips = '/usr/bin/dvips';
$CFG->filter_tex_pathlatex = '/usr/bin/latex';

// Errors
$CFG->local_errorlog_path = '/var/log/apache2/error.log';

// Secretaria
$CFG->local_secretaria_baseurl = '';

// Mail
$CFG->local_xtecmail = true;
$CFG->local_xtecmail_app = 'IOC';
$CFG->local_xtecmail_sender = 'educacio';
$CFG->local_xtecmail_env = 'DEV';
$CFG->local_xtecmail_log = "$CFG->dataroot/xtecmail.log";
$CFG->local_xtecmail_debug = true;

$CFG->xsendfile = 'X-SendFile';

$CFG->local_testing_mode = false;

// No Redis log
$CFG->local_redislock_logging = false;

// Local MUC config
$CFG->redis_servers = '127.0.0.1';
$CFG->altcacheconfigpath = '/dades/html/';

// H5P No library
$CFG->mod_hvp_backup_libraries = '0';

$CFG->preventfilelocking = true;

require_once __DIR__ . '/lib/setup.php';
