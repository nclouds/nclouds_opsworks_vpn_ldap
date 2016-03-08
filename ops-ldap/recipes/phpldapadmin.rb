user 'apache' 


%w{ httpd24 httpd24-devel php54 }.each do |pkg|
   package pkg
end
package 'phpldapadmin'

template '/etc/httpd/conf.d/phpldapadmin.conf' do
  source 'phpldapadmin.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[httpd]", :immediately
end

template '/etc/phpldapadmin/config.php' do
  source 'config.php.erb'
  owner 'root'
  group 'apache'
  mode '0640'
  notifies :restart, "service[httpd]", :immediately
end

service 'httpd' do
  action :enable
end