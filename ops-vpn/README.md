# ops-vpn cookbook

Install openvpnas with yubikey and openldap support

## Supported Platforms

Ubuntu only

## Dependecies

Need to run ops-ldap::default cookbook first to setup openldap server.

## Attributes used in the cookbook

default[:yubikey_ids] 
default[:ldap_host]  = 127.0.0.1
default[:enable_ldap]  = false


## USAGE

The cookbook only enable yubikey by default and doesn't enable ldap authentication by default.

1. Enable ldap by setting the attribute "default[:enable_ldap]  = True"

2. Override the ldap server host to use in the attribute "default[:ldap_host] = 127.0.0.1"

3. To add VPN users - we need to add the ldap users as vpn users with their corresponding yubi key in the attribute "default[:yubikey_ids]"

For example: default[:yubikey_ids] = { "navdeep" => "ccccccevcnji", "ldapuser2" => "ccccccevcnji"}

Note: We need to use the first 12 characters of the yubi key of each user.

4. Change the domain name to use in the template "ops-vpn/templates/default/ldap.conf.erb", we need to use the same domain that we used while creating the openldap server with the cookbook ops-ldap.

5. (Option) If we are using the ospsworks, we can also override attribute "default[:yubikey_ids]" in the opsworks stack settings as Custom JSON to add ldap users with there corresponding yubi key. For example as shown below :

  { "yubikey_ids" : { "navdeep" : "ccccccevcnji" , "ryan" : "ccccccbcjvhf" } }

6. Run the recipe ops-vpn::default to install openvpnas+yubikey+openldap.


## Important URLs

 openvpn client url - https://vpn-server-ip:943/
 openvpn admin url  - https://vpn-server-ip:943/admin


## License and Authors

lihao@nclouds.com
navdeep@nclouds.com
