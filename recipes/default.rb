include_recipe "python"
include_recipe "logrotate"
include_recipe "yum-epel" if platform_family?("rhel")

include_recipe "graphite::whisper"
include_recipe "graphite::carbon"
include_recipe "graphite-api"

include_recipe 'nginx'

template '/etc/nginx/sites-available/graphite' do
  source node['graphite']['nginx']['template']
  cookbook node['graphite']['nginx']['template_cookbook']
  notifies :reload, 'service[nginx]'
  mode '0644'
  owner 'root'
  group 'root'
end

nginx_site 'graphite' do
  template false
end
