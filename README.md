# apachepit

Tarpit functionality for the Apache webserver. Written in mod_lua.

## Requirements

mysql / mariadb server and webserver packages below:

### Fedora / Redhat / Centos

- httpd
- mod_lua
- apr-util-mysql

### Ubuntu / Debian

- apache2-bin
- libaprutil1-dbd-mysql

## Install

- Create DB, user & schema (see SQL/)  **Change default password**
- Enable mod_dbd & mod_lua in Apache
- Add Apache conf (see conf/apachepit.conf)
- Copy apachepit.lua into configured dir (eg /opt/apachepit/lua/)
- Copy error docs into configured dir (eg /opt/apachepit/html/)
- Restart Apache

## TODO

- Whitelisting / Blacklisting
- Update last_seen & hitcount - enable more complex logic
