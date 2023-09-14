#!/bin/bash

echo 'Enabling PHP 8.1 repository...'
sudo amazon-linux-extras enable php8.1 &> /dev/null

echo 'Disabling docker repository...'
sudo amazon-linux-extras disable docker &> /dev/null

echo 'Installing unoconv...'
sudo amazon-linux-extras enable libreoffice &> /dev/null
sudo python -m pip install unoconv &> /dev/null
sudo yum install -y libreoffice &> /dev/null
sudo chmod 777 /usr/share/httpd/ &> /dev/null

echo 'Installing Apache and PHP...'
sudo yum install -y httpd php php-{opcache,curl,gd,xml,intl,pear,mbstring,gettext,zip,soap,sodium} &> /dev/null

echo 'Setting apache to start up on system boot...'
sudo systemctl enable httpd.service &> /dev/null

echo 'Configuring Apache and PHP...'
sudo cp /vms/provision/conf/agora.conf /etc/httpd/conf/
sudo mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
sudo cp /vms/provision/conf/httpd.conf /etc/httpd/conf/

sudo mv /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.bak
sudo mv /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/userdir.conf.bak
sudo mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.bak
sudo mv /etc/httpd/conf.modules.d/00-dav.conf /etc/httpd/conf.modules.d/00-dav.conf.bak
sudo mv /etc/httpd/conf.modules.d/00-lua.conf /etc/httpd/conf.modules.d/00-lua.conf.bak
sudo mv /etc/httpd/conf.modules.d/00-proxy.conf /etc/httpd/conf.modules.d/00-proxy.conf.bak
sudo mv /etc/httpd/conf.modules.d/10-h2.conf /etc/httpd/conf.modules.d/10-h2.conf.bak
sudo mv /etc/httpd/conf.modules.d/10-proxy_h2.conf /etc/httpd/conf.modules.d/10-proxy_h2.conf.bak

sudo sed -i "s@LoadModule access_compat_module modules/mod_access_compat.so@#LoadModule access_compat_module modules/mod_access_compat.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule actions_module modules/mod_actions.so@#LoadModule actions_module modules/mod_actions.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule allowmethods_module modules/mod_allowmethods.so@#LoadModule allowmethods_module modules/mod_allowmethods.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule auth_digest_module modules/mod_auth_digest.so@#LoadModule auth_digest_module modules/mod_auth_digest.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authn_anon_module modules/mod_authn_anon.so@#LoadModule authn_anon_module modules/mod_authn_anon.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authn_dbd_module modules/mod_authn_dbd.so@#LoadModule authn_dbd_module modules/mod_authn_dbd.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authn_dbm_module modules/mod_authn_dbm.so@#LoadModule authn_dbm_module modules/mod_authn_dbm.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authn_socache_module modules/mod_authn_socache.so@#LoadModule authn_socache_module modules/mod_authn_socache.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authz_dbd_module modules/mod_authz_dbd.so@#LoadModule authz_dbd_module modules/mod_authz_dbd.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authz_dbm_module modules/mod_authz_dbm.so@#LoadModule authz_dbm_module modules/mod_authz_dbm.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authz_groupfile_module modules/mod_authz_groupfile.so@#LoadModule authz_groupfile_module modules/mod_authz_groupfile.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authz_host_module modules/mod_authz_host.so@#LoadModule authz_host_module modules/mod_authz_host.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule authz_owner_module modules/mod_authz_owner.so@#LoadModule authz_owner_module modules/mod_authz_owner.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule autoindex_module modules/mod_autoindex.so@#LoadModule autoindex_module modules/mod_autoindex.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule cache_socache_module modules/mod_cache_socache.so@#LoadModule cache_socache_module modules/mod_cache_socache.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule data_module modules/mod_data.so@#LoadModule data_module modules/mod_data.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule dbd_module modules/mod_dbd.so@#LoadModule dbd_module modules/mod_dbd.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule info_module modules/mod_info.so@#LoadModule info_module modules/mod_info.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule macro_module modules/mod_macro.so@#LoadModule macro_module modules/mod_macro.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule slotmem_plain_module modules/mod_slotmem_plain.so@#LoadModule slotmem_plain_module modules/mod_slotmem_plain.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule slotmem_shm_module modules/mod_slotmem_shm.so@#LoadModule slotmem_shm_module modules/mod_slotmem_shm.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule socache_dbm_module modules/mod_socache_dbm.so@#LoadModule socache_dbm_module modules/mod_socache_dbm.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule substitute_module modules/mod_substitute.so@#LoadModule substitute_module modules/mod_substitute.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule suexec_module modules/mod_suexec.so@#LoadModule suexec_module modules/mod_suexec.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule unique_id_module modules/mod_unique_id.so@#LoadModule unique_id_module modules/mod_unique_id.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule userdir_module modules/mod_userdir.so@#LoadModule userdir_module modules/mod_userdir.so@" /etc/httpd/conf.modules.d/00-base.conf

echo 'Configuring fake certificate...'
sudo systemctl enable httpd > /dev/null 2>&1
sudo systemctl start httpd > /dev/null 2>&1
sudo yum install -y mod_ssl > /dev/null 2>&1
pushd /etc/pki/tls/certs/ > /dev/null || exit
sudo ./make-dummy-cert localhost.crt > /dev/null 2>&1
sudo cp localhost.crt ../private/localhost.key > /dev/null
popd > /dev/null || exit

# PHP Configuration
echo 'Configuring PHP...'
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 25M/" /etc/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 25M/" /etc/php.ini
sudo sed -i "s/; max_input_vars = .*/max_input_vars = 6000/" /etc/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = On/" /etc/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 600/" /etc/php.ini

# CLI will be different from web
sudo cp /etc/php.ini /etc/php-cli.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 0/" /etc/php.ini
sudo sed -i "s/max_input_time = .*/max_input_time = 0/" /etc/php-cli.ini

# OPCache configuration
echo 'Configuring OPCache...'
sudo sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php.d/10-opcache.ini
sudo sed -i "s/opcache.memory_consumption=.*/opcache.memory_consumption=256/" /etc/php.d/10-opcache.ini
sudo sed -i "s/opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/" /etc/php.d/10-opcache.ini
sudo sed -i "s/opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/" /etc/php.d/10-opcache.ini
sudo sed -i "s/;opcache.use_cwd=.*/opcache.use_cwd=1/" /etc/php.d/10-opcache.ini
sudo sed -i "s/;opcache.validate_timestamps=.*/opcache.validate_timestamps=1/" /etc/php.d/10-opcache.ini
# 0 for development, 60 for production
sudo sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=0/" /etc/php.d/10-opcache.ini
sudo sed -i "s/;opcache.enable_file_override=.*/opcache.enable_file_override=0/" /etc/php.d/10-opcache.ini

# Log configuration
sudo ln -s /var/log/httpd /var/log/apache2
sudo chmod -R 777 /var/log/apache2/

# Install extension php-imagick. There is no package in the repository, so it must be done manually.
echo 'Installing php-imagick, php-igbinary and php-redis...'
sudo yum install -y php-devel gcc ImageMagick-devel > /dev/null
sudo /usr/bin/bash -c "yes '' | pecl install -f imagick" > /dev/null
sudo /usr/bin/bash -c "pecl install -f igbinary" > /dev/null
sudo /usr/bin/bash -c "yes '' '' | pecl install -f redis" > /dev/null
sudo /usr/bin/bash -c "echo 'extension=imagick.so' > /etc/php.d/30-imagick.ini"
sudo /usr/bin/bash -c "echo 'extension=igbinary.so' > /etc/php.d/30-igbinary.ini"
sudo /usr/bin/bash -c "echo 'extension=redis.so' > /etc/php.d/40-redis.ini"
sudo yum remove -y php-devel gcc ImageMagick-devel > /dev/null

echo 'Installing memcached and redis...'
sudo amazon-linux-extras enable redis6 > /dev/null 2>&1
sudo yum install -y memcached redis php-memcached > /dev/null 2>&1
sudo systemctl enable memcached.service > /dev/null 2>&1
sudo systemctl enable redis > /dev/null 2>&1
sudo systemctl start memcached.service > /dev/null 2>&1
sudo systemctl start redis > /dev/null 2>&1

sudo service httpd start > /dev/null 2>&1

echo 'Installing and configuring supervisor...'
sudo amazon-linux-extras enable epel > /dev/null 2>&1
sudo yum install -y epel-release > /dev/null 2>&1
sudo yum install -y supervisor > /dev/null 2>&1
sudo cp /vms/provision/conf/portal_cron.ini /etc/supervisord.d/portal_cron.ini
sudo systemctl enable supervisord.service > /dev/null 2>&1
sudo systemctl start supervisord.service > /dev/null 2>&1
