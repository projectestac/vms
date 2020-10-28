<?php

unset($CFG);
global $CFG;

$CFG = new stdClass();
$CFG->dbtype = 'pgsql';
$CFG->dblibrary = 'native';
$CFG->dbhost = 'localhost';
$CFG->dbname = 'odissea';
$CFG->dbuser = 'odissea';
$CFG->dbpass = 'agora';
$CFG->prefix = 'm2';

$CFG->dboptions = [
    'dbpersist' => 0,
    'dbsocket' => 0,
    'dbport' => 5432,
];

$CFG->wwwroot = 'https://odissea-aws.xtec.cat';
$CFG->dataroot = '/dades/data/odisseadata';
$CFG->admin = 'admin';

$CFG->passwordsaltmain = 'abcdefghijklmnopqrstuvwxyz';
$CFG->memcache_servers = '127.0.0.1';
$CFG->redis_servers = '127.0.0.1';

// E-mail
$CFG->smtphosts = '';
$CFG->smtpuser = '';
$CFG->smtppass = '';
$CFG->noreplyaddress = '';
 
// Uncomment to debug
// @error_reporting(E_ALL | E_STRICT); // NOT FOR PRODUCTION SERVERS!
// @ini_set('display_errors', '1');    // NOT FOR PRODUCTION SERVERS!
// $CFG->debug = (E_ALL | E_STRICT);   // === DEBUG_DEVELOPER - NOT FOR PRODUCTION SERVERS!
// $CFG->debugdisplay = 1;             // NOT FOR PRODUCTION SERVERS!

require_once(dirname(__FILE__) . '/local/agora/lib.php');
require_once(dirname(__FILE__) . '/settings.php');
require_once(dirname(__FILE__) . '/lib/setup.php');
