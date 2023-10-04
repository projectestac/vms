<!DOCTYPE html>
<html lang="ca">
<head>
    <meta charset="UTF-8">
    <title>Virtual Machine menu</title>
    <style type="text/css">
        body {
            font-family: sans-serif;
        }

        fieldset {
            border: 1px solid #ddd;
            width: 46%;
            float: left;
            margin: 10px;
            border-radius: 4px;
        }

        legend {
            color: #888;
            font-weight: bold;
            padding-left: 5px;
            padding-right: 5px;
        }

        a {
            text-decoration: none;
        }

        h2 {
            text-align: center;
            color: #888;
        }

        img {
            vertical-align: middle;
        }
    </style>
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
</head>

<body>
<h2>Applications</h2>

<fieldset>
    <legend><img alt="Àgora" src="img/agora.gif"/></legend>

    <img src="img/moodle.png" alt="Moodle"/>
    <a href="/centre-1/moodle/">[Client 1]</a>
    <a href="/centre-2/moodle/">[Client 2]</a>
    <a href="/centre-3/moodle/">[Client 3]</a>
    <a href="/centre-4/moodle/">[Client 4]</a>
    <br/>

    <img src="img/nodes.png" alt="Nodes"/>
    <a href="/centre-1/">[Client 1]</a>
    <a href="/centre-2/">[Client 2]</a>
    <a href="/centre-3/">[Client 3]</a>
    <a href="/centre-4/">[Client 4]</a>
    <a href="/centre-5/">[Client 5]</a>
    <a href="/centre-6/">[Client 6]</a>
    <a href="/centre-7/">[Client 7]</a>
    <a href="/centre-8/">[Client 8]</a>
    <a href="/centre-9/">[Client 9]</a>
    <br/>
    <br/>

    <a href="/portal/">[Portal]</a>
    <br/>
    <br/>

    <a href="/config/sync_to_file.php?debug=on&print=on&force=true">[Actualitza allSchools]</a>
    <a href="/config/statistics.php">[Recull estadístiques]</a>
    <br/>
    <a href="/config/createSchoolsListsFiles.php?service=moodle2">[Llista URL crons Moodle]</a>
    <a href="/config/createSchoolsListsFiles.php?service=nodes">[Llista URL crons Nodes]</a>
    <a href="/config/createSchoolsListsFiles.php?update&new_version">[Llista URL actualitzacions]</a>
    <br/>
</fieldset>

<fieldset>
    <legend>Gestió</legend>
    <a href="/config/phpsysinfo/">[phpSysInfo]</a>
    <br/>
    <a href="/config/phpmemcached/">[phpMemCached]</a>
    <br/>
    <a href="/config/phpredisadmin/">[phpRedisAdmin]</a>
    <br/>
    <a href="/config/phpmyadmin/">[phpMyAdmin]</a>
    <br/>
</fieldset>

</body>
</html>
