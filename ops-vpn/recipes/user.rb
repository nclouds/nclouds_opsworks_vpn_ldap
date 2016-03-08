template '/etc/yubkey_mappings' do
  source 'yubkey_mappings.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables ( {:yubikey_ids => node[:yubikey_ids]} )
end
node[:yubikey_ids].each do |user,id|  
  bash 'create vpn #{user}' do
     user 'root'
     cwd "/usr/local/openvpn_as/"
     code <<-EOH
     /usr/local/openvpn_as/scripts/sacli -u #{user} -k type -v user_connect UserPropPut
     /usr/local/openvpn_as/scripts/sacli -u #{user} -k access_to.1 -v +NAT:10.0.0.0/8 UserPropPut
     /usr/local/openvpn_as/scripts/sacli start
     EOH
  end
end