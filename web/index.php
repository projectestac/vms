<!DOCTYPE html>
<html lang="ca">
<head>
	<meta charset="UTF-8">
	<title>Menú de la Màquina Virtual</title>
	<style type="text/css">
		body {  font-family: sans-serif;}
		fieldset { border:1px solid #ddd; width:46%; float:left; margin:10px; border-radius:4px; }
		legend { color:#888; font-weight:bold; padding-left:5px; padding-right:5px; }
		a { text-decoration:none; }
		h2 { text-align:center; color:#888; }
		img {vertical-align: middle;}
	</style>
	<link rel="icon" href="favicon.ico" type="image/x-icon" />
</head>

<body>
	<h2>Aplicacions</h2>

    <fieldset>
        <legend>Àgora</legend>

        <img src="/portal/modules/Agoraportal/images/moodle2.gif" alt="Moodle"/>
        <a href="/usu1/moodle/">[usu1]</a>
        <a href="/usu2/moodle/">[usu2]</a>
        <a href="/usu3/moodle/">[usu3]</a>
        <a href="/usu4/moodle/">[usu4]</a>
        <br/>

        <img src="/portal/modules/Agoraportal/images/nodes.gif" alt="Nodes"/>
        <a href="/usu1/">[usu1]</a>
        <a href="/usu2/">[usu2]</a>
        <a href="/usu3/">[usu3]</a>
        <a href="/usu4/">[usu4]</a>
        <a href="/usu5/">[usu5]</a>
        <a href="/usu6/">[usu6]</a>
        <a href="/usu7/">[usu7]</a>
        <a href="/usu8/">[usu8]</a>
        <a href="/usu9/">[usu9]</a>
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
