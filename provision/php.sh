#!/bin/bash

echo 'Installing PHP 8.3 and extra packages (including apache)...'
sudo dnf install php8.3 php8.3-{gd,intl,zip,soap} -y > /dev/null 2>&1

echo 'Installing LibreOffice...'
LO_VERSION="25.8.3"
LO_REVISION="${LO_VERSION}.2"
wget https://download.documentfoundation.org/libreoffice/stable/${LO_VERSION}/rpm/x86_64/LibreOffice_${LO_VERSION}_Linux_x86-64_rpm.tar.gz > /dev/null 2>&1
tar -zxvf LibreOffice_${LO_VERSION}_Linux_x86-64_rpm.tar.gz > /dev/null 2>&1
pushd LibreOffice_${LO_REVISION}_Linux_x86-64_rpm/RPMS/ > /dev/null || exit
sudo dnf install ./*.rpm -y > /dev/null 2>&1
popd > /dev/null || exit
sudo rm -rf LibreOffice_* > /dev/null 2>&1

echo 'Installing unoconv...'
sudo curl -o /usr/bin/unoconv https://raw.githubusercontent.com/dagwieers/unoconv/master/unoconv > /dev/null 2>&1
sudo chmod +x /usr/bin/unoconv > /dev/null 2>&1
sudo ln -s /usr/bin/python3 /usr/bin/python > /dev/null 2>&1
sudo dnf install libxcrypt-compat -y > /dev/null 2>&1

echo 'Configuring LibreOffice headless service...'
sudo mkdir -p /home/apache
sudo chown apache:apache /home/apache
sudo usermod -d /home/apache apache
sudo dnf install cairo libXinerama libXext libSM libICE libXrender libX11 libX11-xcb-1.8.10-2.amzn2023.0.1.x86_64 -y > /dev/null 2>&1
sudo cp /vms/provision/conf/libreoffice-headless.service /etc/systemd/system/libreoffice-headless.service
sudo chmod 755 /etc/systemd/system/libreoffice-headless.service
sudo systemctl daemon-reload > /dev/null 2>&1
sudo systemctl enable --now libreoffice-headless > /dev/null 2>&1

echo 'Configuring Apache...'
sudo cp /vms/provision/conf/agora.conf /etc/httpd/conf/
sudo mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
sudo cp /vms/provision/conf/httpd.conf /etc/httpd/conf/
sudo sed -i "s/;listen.owner = .*/listen.owner = apache/" /etc/php-fpm.d/www.conf
sudo sed -i "s/;listen.group = .*/listen.group = apache/" /etc/php-fpm.d/www.conf
sudo sed -i "s/;listen.mode = .*/listen.mode = 0660/" /etc/php-fpm.d/www.conf

sudo mv /etc/httpd/conf.d/autoindex.conf /etc/httpd/conf.d/autoindex.conf.bak
sudo mv /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/userdir.conf.bak
sudo mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.bak
sudo mv /etc/httpd/conf.modules.d/00-dav.conf /etc/httpd/conf.modules.d/00-dav.conf.bak
sudo mv /etc/httpd/conf.modules.d/00-lua.conf /etc/httpd/conf.modules.d/00-lua.conf.bak
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
sudo sed -i "s@LoadModule socache_dbm_module modules/mod_socache_dbm.so@#LoadModule socache_dbm_module modules/mod_socache_dbm.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule substitute_module modules/mod_substitute.so@#LoadModule substitute_module modules/mod_substitute.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule suexec_module modules/mod_suexec.so@#LoadModule suexec_module modules/mod_suexec.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule unique_id_module modules/mod_unique_id.so@#LoadModule unique_id_module modules/mod_unique_id.so@" /etc/httpd/conf.modules.d/00-base.conf
sudo sed -i "s@LoadModule userdir_module modules/mod_userdir.so@#LoadModule userdir_module modules/mod_userdir.so@" /etc/httpd/conf.modules.d/00-base.conf

echo 'Configuring fake certificate...'
sudo dnf install -y mod_ssl > /dev/null 2>&1
pushd /etc/pki/tls/certs/ > /dev/null 2>&1 || exit
sudo make-dummy-cert localhost.crt > /dev/null 2>&1
sudo cp localhost.crt ../private/localhost.key > /dev/null 2>&1
popd > /dev/null || exit

# PHP Configuration
echo 'Configuring PHP...'
sudo sed -i '$ a\date.timezone = "Europe/Madrid"' /etc/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 200M/" /etc/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 200M/" /etc/php.ini
sudo sed -i "s/;max_input_vars = .*/max_input_vars = 6000/" /etc/php.ini
sudo sed -i "s/allow_url_fopen = .*/allow_url_fopen = On/" /etc/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 600/" /etc/php.ini

# CLI will be different from web
sudo cp /etc/php.ini /etc/php-cli.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 0/" /etc/php-cli.ini
sudo sed -i "s/max_input_time = .*/max_input_time = 0/" /etc/php-cli.ini

# OPCache configuration
echo 'Configuring OPCache...'
sudo sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php.d/10-opcache.ini
sudo sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=256/" /etc/php.d/10-opcache.ini
sudo sed -i "s/opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=16/" /etc/php.d/10-opcache.ini
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
sudo dnf install -y php-devel php-pear ImageMagick-devel gcc make > /dev/null 2>&1
sudo /usr/bin/bash -c "yes '' | pecl install -f imagick" > /dev/null 2>&1
sudo /usr/bin/bash -c "pecl install -f igbinary" > /dev/null 2>&1
sudo /usr/bin/bash -c "printf \"yes\n\n\" | pecl install -f redis" > /dev/null 2>&1
sudo /usr/bin/bash -c "echo 'extension=imagick.so' > /etc/php.d/30-imagick.ini"
sudo /usr/bin/bash -c "echo 'extension=igbinary.so' > /etc/php.d/30-igbinary.ini"
sudo /usr/bin/bash -c "echo 'extension=redis.so' > /etc/php.d/40-redis.ini"
sudo dnf remove -y php-devel php-pear ImageMagick-devel gcc make > /dev/null 2>&1

echo 'Setting apache to start up on system boot...'
sudo systemctl daemon-reload
sudo systemctl enable httpd > /dev/null 2>&1
sudo systemctl enable php-fpm > /dev/null 2>&1
sudo systemctl start httpd
sudo systemctl start php-fpm
