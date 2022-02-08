<?php

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype = 'mysqli';
$CFG->dbhost = 'localhost';
$CFG->dboptions = [
    'dbport' => 3306,
    'dbengine' => 'InnoDB',
    'dbpersist' => 0,
    'dbsocket' => 0,
];
$CFG->dbname = 'moodle310';
$CFG->dbuser = 'root';
$CFG->dbpass = 'agora';
$CFG->prefix = 'mdl_';
$CFG->wwwroot = 'https://ioc-aws.xtec.cat/moodle310';
$CFG->dirroot = '/dades/html/moodle310';
$CFG->dataroot = '/dades/data/moodledata310';
$CFG->directorypermissions = 00777;
$CFG->cronclionly = true;

$CFG->cachedir = '/dades/data/moodledata310/cache';
$CFG->localcachedir = '/dades/localdata/localmuc310';

$CFG->zip = '/usr/bin/zip';
$CFG->unzip = '/usr/bin/unzip';
$CFG->pathtodu = '/usr/bin/du';

$CFG->filter_tex_pathconvert = '/usr/bin/convert';
$CFG->filter_tex_pathdvips = '/usr/bin/dvips';
$CFG->filter_tex_pathlatex = '/usr/bin/latex';

// Materials
$CFG->local_materials_secret_url = '';
$CFG->local_materials_secret_token = '';

// Secretaria
$CFG->local_secretaria_baseurl = '';

// Mail
$CFG->local_xtecmail = true;
$CFG->local_xtecmail_app = 'IOC';
$CFG->local_xtecmail_sender = 'educacio';
$CFG->local_xtecmail_env = 'PRE';
$CFG->local_xtecmail_log = "$CFG->dataroot/xtecmail.log";
$CFG->local_xtecmail_debug = true;

$CFG->xsendfile = 'X-SendFile';

// Mode proves
$CFG->local_testing_mode = false;

require_once __DIR__ . '/lib/setup.php';
