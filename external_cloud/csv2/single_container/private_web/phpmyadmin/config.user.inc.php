<?php
$cfg['ForceSSL'] = true;

$i = 0;
$i++;
$cfg['Servers'][$i]['ssl'] = true;
$cfg['Servers'][$i]['ssl_key'] = '/data/ssl/server.key';
$cfg['Servers'][$i]['ssl_cert'] = '/data/ssl/server.crt';
?>