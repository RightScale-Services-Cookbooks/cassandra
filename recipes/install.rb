#
# Cookbook Name:: cassandra
# Recipe:: install
#
# Copyright 2013, RightScale
#
# All rights reserved - Do Not Redistribute
#

# Recommended production settings: http://www.datastax.com/documentation/cassandra/1.2/webhelp/index.html#cassandra/install/installRecommendSettings.html

include_recipe "machine_tag::default"

machine_tag "cassandra:seed_host=#{node[:cassandra][:is_seed_host]}" do
  action :create
end

# Tag host with broadcast and listen addresses for discovery
machine_tag "cassandra:broadcast_address=#{node[:cassandra][:broadcast_address]}" do
  action :create
end

machine_tag "cassandra:listen_address=#{node[:cassandra][:listen_address]}" do
  action :create
end

# Find install file name
tarball = node[:cassandra][:url].split('/').last

# Full path to install directory
install_dir = tarball.gsub(/-bin.tar.gz$/, "")

# Download Cassandra to Chef cache
remote_file "#{Chef::Config[:file_cache_path]}/#{tarball}" do
  source node[:cassandra][:url]
  action :create
end

execute "untar Cassandra" do
  command "tar zxf #{Chef::Config[:file_cache_path]}/#{tarball} -C /opt"
end

execute "Delete Windows configs" do
  command "rm -f /opt/#{install_dir}/bin/*.ps1 /opt/#{install_dir}/*.bat"
end

group "cassandra" do
  action :create
end

user "cassandra" do
  group "cassandra"
  action :create
end

directory "/etc/cassandra/conf" do
  recursive true
end

cookbook_file "/etc/sysctl.conf" do
  source "sysctl.conf"
  mode "0644"
  owner "root"
  group "root"
  action :create
end

cookbook_file "/etc/security/limits.d/cassandra.conf" do
  source "cassandra.conf"
  owner "root"
  group "root"
  mode "0644"
  backup false
  action :create
end

cookbook_file "/etc/cassandra/conf/cassandra-env.sh" do
  source "cassandra-env.sh"
  owner "cassandra"
  group "cassandra"
  mode "0755"
  action :create
end

bash "disable_swap" do
  flags "-ex"
  code <<-EOM
    swapoff --all
  EOM
end
