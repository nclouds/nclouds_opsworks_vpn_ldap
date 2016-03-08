remote_file "/tmp/openvpn-as-2.0.21-Ubuntu14.amd_64.deb" do
  source "http://swupdate.openvpn.org/as/openvpn-as-2.0.21-Ubuntu14.amd_64.deb"
  action :create
end

dpkg_package "openvpn-as" do
  source "/tmp/openvpn-as-2.0.21-Ubuntu14.amd_64.deb"
  action :install
  not_if 'dpkg -l|grep openvpn-as'
end

package 'libpam-yubico'

bash 'libpam-ldap' do
  user 'root'
  cwd "/tmp"
  code <<-EOH
  DEBIAN_FRONTEND=noninteractive apt-get install -qq libpam-ldap
  EOH
end


template '/etc/pam.d/openvpnas' do
  source 'openvpnas.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[openvpnas]", :immediately
end


template '/etc/ldap.conf' do
  source 'ldap.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[openvpnas]", :immediately
end



service 'openvpnas' do
  action :enable
end
include_recipe "ops-vpn::user"
