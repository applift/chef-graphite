#
# Cookbook Name:: graphite
# Recipe:: graphite_web
#
# Copyright (C) 2014, Chef Software, Inc <legal@getchef.com>

include_recipe "build-essential"

if platform_family?("debian")
  packages = [ "python-cairo-dev", "python-django", "python-django-tagging", "python-memcache", "python-rrdtool" ]
elsif platform_family?("fedora", "rhel")
  packages = [ "bitmap", "bitmap-fonts", "Django", "django-tagging", "pycairo", "python-memcached", "rrdtool-python" ]

  # bitmap-fonts not available
  packages.reject! { |pkg| pkg == "bitmap-fonts" } if platform?("amazon")
else
  packages = [ "python-cairo-dev", "python-django", "python-django-tagging", "python-memcache", "python-rrdtool" ]
end

packages.each do |graphite_package|
  package graphite_package do
    action :install
  end
end

python_pip "graphite-web" do
  version node["graphite"]["version"]
  options %Q{--install-option="--prefix=#{node['graphite']['home']}" --install-option="--install-lib=#{node['graphite']['home']}/webapp"}
  action :install
end

template "#{node['graphite']['home']}/webapp/local_settings.py" do
  mode "0644"
  source "local_settings.py.erb"
  owner 'root'
  group 'root'
  variables(
    :home           => node["graphite"]["home"],
    :whisper_dir    => node["graphite"]["carbon"]["whisper_dir"],
    :timezone       => node["graphite"]["web"]["timezone"],
    :secretkey      => node["graphite"]["web"]["secretkey"],
    :memcache_hosts => node["graphite"]["web"]["memcache_hosts"],
    :mysql_server   => node["graphite"]["web"]["mysql_server"],
    :mysql_username => node["graphite"]["web"]["mysql_username"],
    :mysql_password => node["graphite"]["web"]["mysql_password"],
    :mysql_port     => node["graphite"]["web"]["mysql_port"]
  )
end

directory "#{node['graphite']['home']}/storage/log" do
  owner node["nginx"]["user"]
  group node["nginx"]["group"]
end

directory node['graphite']['carbon']['whisper_dir'] do
  owner node["nginx"]["user"]
  group node["nginx"]["group"]
end

directory "#{node['graphite']['home']}/storage/log/webapp" do
  owner node["nginx"]["user"]
  group node["nginx"]["group"]
end

cookbook_file "#{node['graphite']['home']}/storage/graphite.db" do
  owner node["nginx"]["user"]
  group node["nginx"]["group"]
  action :create_if_missing
end

logrotate_app "dashboard" do
  cookbook "logrotate"
  path "#{node['graphite']['home']}/storage/log/webapp/*.log"
  frequency "daily"
  rotate 7
  create "644 root root"
end

include_recipe "graphite::_nginx"
