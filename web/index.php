<!DOCTYPE html>
<html lang="ca">
<head>
	<meta charset="UTF-8">
	<title>Menú de la Màquina Virtual</title>
	<style type="text/css">
		body {  font-family: sans-serif;}
		fieldset { border:1px solid #ddd; width:45%; float:left; margin:10px;
                   border-radius: 4px; }
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
		<legend><img alt="Àgora" src="img/agora.gif"/></legend>

		<img src="img/moodle.png" alt="Moodle"/>
		<a href="/agora/usu1/moodle/">[usu1]</a>
		<a href="/agora/usu2/moodle/">[usu2]</a>
		<a href="/agora/usu3/moodle/">[usu3]</a>
		<a href="/agora/usu4/moodle/">[usu4]</a>
		<br />

		<img src="img/nodes.png" alt="Nodes"/>
		<a href="/agora/usu1/">[usu1]</a>
		<a href="/agora/usu2/">[usu2]</a>
		<a href="/agora/usu3/">[usu3]</a>
		<a href="/agora/usu4/">[usu4]</a>
		<br />

		<img src="img/intraweb.gif" alt="Intranet"/>
		<a href="/agora/usu1/intranet/">[usu1]</a>
		<a href="/agora/usu2/intranet/">[usu2]</a>
		<a href="/agora/usu3/intranet/">[usu3]</a>
		<a href="/agora/usu4/intranet/">[usu4]</a>
		<br />

		<a href="/agora/portal/">[Portal]</a>
		<br />

		<a href="/agora/config/sync_to_file.php?debug=on&print&force=true">[Actualitza allSchools]</a>
		<a href="/agora/config/statistics.php">[Recull estadístiques]</a>
		<br />
	</fieldset>

	<fieldset>
		<legend><img src="img/odissea.png" alt="Odissea"/></legend>
		<a href="/odissea/">[Moodle 2]</a>
	</fieldset>

	<fieldset>
		<legend><img src="img/blocs.png" alt="Blocs"/></legend>
		<a href="/blocs/">[XTECBlocs]</a>
	</fieldset>

	<div style="clear:both;"></div>

	<fieldset>
		<legend><img src="img/prestatgeria.png" alt="Prestatgeria"/></legend>
		<a href="/prestatgeria/">[Prestatgeria]</a>
	</fieldset>

	<fieldset>
		<legend><img src="img/alexandria.png" alt="Alexandria"/></legend>
		<a href="/alexandria/">[Alexandria]</a>
	</fieldset>

	<fieldset>
		<legend> MPS: </legend>
		<a href="/mps/">[Simulador d'editorial Marsupial]</a>
	</fieldset>

	<fieldset>
		<legend> Gestió </legend>
		<a href="<?php print "http://".$_SERVER["SERVER_NAME"].":8080/apex"?>">[Oracle admin]</a>
		<a href="/phpmyadmin/">[MySQL admin]</a>
		<br/>
		<a href="/agora/config/phpsysinfo/">[phpSysInfo]</a>
		<a href="/agora/config/phpmemcache/">[phpMemCache]</a>
		<br/>
		<a href="/opcache.php">[OpCache]</a>
		<a href="/phpinfo.php">[PHPInfo]</a>
	</fieldset>

</body>
</html>
