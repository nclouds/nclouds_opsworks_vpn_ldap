package 'portreserve'
package 'libtool-ltdl-devel'
package 'cyrus-sasl-devel'
package 'openldap'
package 'openldap-devel'
package 'openldap-servers'
package 'openldap-clients'




bash "remove_openldap_old" do
  code <<-EOH
  cd /etc/openldap/
  rm -fR /etc/openldap/slapd.d
  EOH
end

template '/etc/openldap/ldap.conf' do
  source 'ldap.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/openldap/slapd.conf' do
  source 'slapd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

directory "/var/lib/openldap-data" do
  mode 0755
  owner 'ldap'
  group 'ldap'
  action :create
  notifies :restart, "service[slapd]", :immediately
end
template '/etc/openldap/base.ldif' do
  source 'base.ldif.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

bash 'import openldap  base' do
  user 'root'
  ignore_failure true
  cwd "/etc/openldap"
  code <<-EOH
  ldapadd -x -D "cn=admin,dc=nclouds,dc=com" -w password -f base.ldif
  EOH
end

service 'slapd' do
  action [:start ,:enable]
end
