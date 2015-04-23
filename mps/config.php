<?php  /// Moodle Configuration File

unset($CFG);

$CFG = new StdClass();

$CFG->dbtype    = 'mysql';
$CFG->dbhost    = 'localhost';
$CFG->dbname    = 'mps';
$CFG->dbuser    = 'root';
$CFG->dbpass    = 'agora';
$CFG->dbpersist =  false;
$CFG->prefix    = 'mps_';

$CFG->wwwroot   = 'http://agora/mps';
$CFG->dirroot   = '/dades/mps/src';
$CFG->dataroot  = '/dades/mps/mpsdata';
$CFG->admin     = 'application/admin';

$CFG->directorypermissions = 00777;  // try 02777 on a server in Safe Mode

require_once("$CFG->dirroot/lib/setup.php");

