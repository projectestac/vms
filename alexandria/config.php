<?php
unset($CFG);
global $CFG;

$CFG = new stdClass();

$CFG->dbtype = 'pgsql';
$CFG->dblibrary = 'native';
$CFG->dbhost = 'localhost';
$CFG->dbname = 'alexandria';
$CFG->dbuser = 'alexandria';
$CFG->dbpass = 'agora';
$CFG->prefix = 'mdl_';
$CFG->dboptions = [
    'dbpersist' => false,
    'dbsocket' => false,
    'dbport' => 5432,
];

$CFG->wwwroot = 'https://alexandria-aws.xtec.cat';
$CFG->dataroot = '/dades/data';
$CFG->altcacheconfigpath = dirname(__FILE__) . '/local/agora/muc/';
$CFG->agora_muc_path = '/dades/localdata';
$CFG->cachedir = $CFG->agora_muc_path . '/cache';
$CFG->localcachedir = $CFG->agora_muc_path . '/localcache';

$CFG->admin = 'admin';
$CFG->directorypermissions = 02777;

$CFG->langotherroot = dirname(__FILE__) . '/langpacks/';
$CFG->langlocalroot = dirname(__FILE__) . '/langpacks/';

$CFG->siteidentifier = md5($CFG->dbuser) . explode('//', $CFG->wwwroot)[1];

$CFG->iseoi = false;

$CFG->passwordsaltmain = '/PN~dd>bLw*swEOKaMa3j9cn*vcb';
$CFG->memcache_servers = '127.0.0.1';
$CFG->memcache_prefix = 'alex_';
$CFG->redis_servers = '127.0.0.1';
$CFG->redis_prefix = 'alex_';

$CFG->recaptchapublickey = '';
$CFG->recaptchaprivatekey = '';

// E-mail
$CFG->smtphosts = '';
$CFG->smtpuser = '';
$CFG->smtppass = '';
$CFG->noreplyaddress = '';
$CFG->supportemail = '';
$CFG->smtpsecure = 'tls';
$CFG->smtpmaxbulk = 15;
$CFG->digestmailtime = 1;
$CFG->emailfromvia = 0;
$CFG->mailheader = '[Alexandria]';

// This variable must be defined
$CFG->apligestenv = '';

// Uncomment to debug
// @error_reporting(E_ALL | E_STRICT); // NOT FOR PRODUCTION SERVERS!
// @ini_set('display_errors', '1');    // NOT FOR PRODUCTION SERVERS!
// $CFG->debug = (E_ALL | E_STRICT);   // === DEBUG_DEVELOPER - NOT FOR PRODUCTION SERVERS!
// $CFG->debugdisplay = 1;             // NOT FOR PRODUCTION SERVERS!

require_once(dirname(__FILE__) . '/local/agora/lib.php');
require_once(dirname(__FILE__) . '/lib/setup.php');
