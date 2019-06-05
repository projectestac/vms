<?php  // Moodle configuration file
unset($CFG);
global $CFG;

$CFG = new stdClass();
$CFG->dbtype    = 'oci';
$CFG->dblibrary = 'native';
$CFG->dbhost    = '';
$CFG->dbname    = 'XE';
$CFG->dbuser    = 'odissea';
$CFG->dbpass    = 'agora';
$CFG->prefix    = 'm2';

global $agora;
$agora['moodle2']['repository_files'] = '/repository/files/';

$CFG->dboptions = array (
    'dbpersist' => true,
    'dbsocket' => false,
    'dbport' => ''
);


$CFG->wwwroot   = 'https://agora-virtual.xtec.cat/odissea';
$CFG->dataroot  = '/dades/odissea/docs';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 0777;

$CFG->passwordsaltalt1 = '';
$CFG->passwordsaltmain = 'y7a!Eb019n8Z5*43Sl5J&ly4pjJUk-b';

$CFG->apligestenv = 'LOCAL';
$agora['server']['enviroment'] = 'LOCAL';
$CFG->memcache_servers = "127.0.0.1";
$CFG->memcache_prefix = $CFG->siteidentifier = 'odi_dev';


require_once(dirname(__FILE__) . '/settings.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
require_once(dirname(__FILE__) . '/lib/setup.php');
