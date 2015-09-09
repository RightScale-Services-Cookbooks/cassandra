#
# Cookbook Name:: cassandra
# Recipe:: configure
#
# Copyright 2013, RightScale
#
# All rights reserved - Do Not Redistribute
#

class Chef::Recipe
  include Chef::MachineTagHelper
end

seed_ips, dirs = Array.new, Array.new
rack, datacenter = nil, nil

# Find datacenter and rack that this host belongs to
if node[:cloud][:provider] == "ec2"
  datacenter = "ec2-#{node[:ec2][:placement][:availability_zone].chop}"
  rack       = "#{node[:ec2][:placement][:availability_zone]}"
elsif node[:cloud][:provider] == "google"
  datacenter = "google-#{node[:google][:zone].split('/').last.chop.chop}"
  rack       =  "#{node[:google][:zone].split('/').last}"
end

# Collect directories to create
dirs.push(node[:cassandra][:commitlog_directory])
dirs.push(node[:cassandra][:saved_caches_directory])
dirs += node[:cassandra][:data_file_directories]

# Find hosts that are going to be Cassandra seeds
seed_hosts = tag_search(node, "cassandra:seed_host=true")

seed_hosts.each do |seed|
  seed_ips << seed["cassandra:broadcast_address"].first.split("=").last
end


# Create Cassandra directories
dirs.each do |dir|
  directory "#{dir}" do
    owner "cassandra"
    group "cassandra"
    mode "0755"
    recursive true
    action :create
  end
end

# Install main Cassandra config file
template "/etc/cassandra/conf/cassandra.yaml" do
  source "#{node[:cassandra][:require_inter_node_encryption]}-cassandra.yaml.erb"
  owner "cassandra"
  group "cassandra"
  mode "0644"
 
  variables({
    :cluster_name           => node[:cassandra][:cluster_name],
    :commitlog_directory    => node[:cassandra][:commitlog_directory],
    :data_file_directories  => node[:cassandra][:data_file_directories],
    :saved_caches_directory => node[:cassandra][:saved_caches_directory],
    :encryption_password    => node[:cassandra][:encryption_password],
    :authorizer             => node[:cassandra][:authorizer],
    :authenticator          => node[:cassandra][:authenticator],
    :listen_address         => node[:cassandra][:listen_address],
    :broadcast_address      => node[:cassandra][:broadcast_address],
    :seeds                  => seed_ips
  })
end

template "/etc/cassandra/conf/cassandra-rackdc.properties" do
  source "cassandra-rackdc.properties.erb"
  owner "cassandra"
  group "cassandra"
  mode "0644"
  variables({
    :datacenter => datacenter,
    :rack       => rack
  })
end

# Install Cassandra truststore / keystore certs if needed
if node[:cassandra][:require_inter_node_encryption] == "true"
  bash "download_keystore" do
    code <<-EOM
      export STORAGE_ACCOUNT_ID="#{node[:cassandra][:storage_account_id]}"
      export STORAGE_ACCOUNT_SECRET="#{node[:cassandra][:storage_account_secret]}"
      /opt/rightscale/sandbox/bin/ros_util get -c "#{node[:cassandra][:bucket]}" -s "#{node[:cassandra][:keystore]}" \
        -C "#{node[:cassandra][:provider]}" -d "/etc/cassandra/conf/keystore"
      chmod 0440 /etc/cassandra/conf/keystore
      chown cassandra:cassandra /etc/cassandra/conf/keystore
    EOM
  end

  bash "download_truststore" do
    code <<-EOM
      export STORAGE_ACCOUNT_ID="#{node[:cassandra][:storage_account_id]}"
      export STORAGE_ACCOUNT_SECRET="#{node[:cassandra][:storage_account_secret]}"
      /opt/rightscale/sandbox/bin/ros_util get -c "#{node[:cassandra][:bucket]}" -s "#{node[:cassandra][:truststore]}" \
        -C "#{node[:cassandra][:provider]}" -d "/etc/cassandra/conf/truststore"
      chmod 0440 /etc/cassandra/conf/truststore
      chown cassandra:cassandra /etc/cassandra/conf/truststore
    EOM
  end
end
