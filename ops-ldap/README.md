## ops-ldap-cookbook

 Install openldap server with PhPladpadmin. phpldapadmin is the web interface for managing ldap server - adding ldap users etc.

## Supported Platforms

 Tested on Amazon Linux

## Attributes

 default[:ldap_password]

 Note: Note: We can use the "slappasswd" OpenLDAP password utility to change the admin password and update the cookbook attribute "default[:ldap_password]" to use the new password.


### USAGE

1. Please change domain to use for the ldap server before running the cookbook in the template ldap.conf.erb

2. Allow ports 80 and 389(ldap) in the firewall/securitygroup. 

3. Then execute this recipe "ops-ldap::default"

  ### To add users via PhPldapadmin
     
     1. Login to the phpldapadmin on the url - http://ldap-server-ip/phpldapadmin

     username: cn=admin,dc=nclouds,dc=com
     password:  set in the cookbook attribute (Default: AdmiN_123# )

    2. First we need to create a posix group in the phpldapadmin. For example, vpnusers.

    3. Then create a ldap user with the posix group created in #2.

## Importan URLS to note

 PhPldapadmin url is http://ldap-server-ip/phpldapadmin 

## CHALLENGES Faced

 If You get this error "Base cannot be created with the PLA" when you first time logged into the phpldapadmin. You need to import the below ldif via the phpldapadmin web interface:

 dn: dc=nclouds,dc=com
 dc: nclouds
 objectClass: top
 objectClass: domain

 Note: We need to add the domain in the ldif which we need to setup in the ldap.


## License and Authors

lihao@nclouds.com
navdeep@nclouds.com
