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

tarball = node[:cassandra][:url].split('/').last
install_dir = tarball.gsub(/-bin.tar.gz$/, "")

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

#cookbook_file "/etc/sysctl.conf" do
  #source "sysctl.conf"
  #mode "0644"
  #owner "root"
  #group "root"
  #action :create
#end

#cookbook_file "/etc/security/limits.d/cassandra.conf" do
  #source "cassandra.conf"
  #owner "root"
  #group "root"
  #mode "0644"
  #backup false
  #action :create
#end

#cookbook_file "/etc/cassandra/conf/cassandra-env.sh" do
  #source "cassandra-env.sh"
  #owner "cassandra"
  #group "cassandra"
  #mode "0755"
  #action :create
#end

bash "disable_swap" do
  flags "-ex"
  code <<-EOM
    swapoff --all
  EOM
end
