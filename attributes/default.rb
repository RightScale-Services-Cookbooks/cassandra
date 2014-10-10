#
# Cookbook Name:: cassandra
#
# Copyright 2013, RightScale
#
# All rights reserved - Do Not Redistribute
#

default[:cassandra][:version]          = "https://s3.amazonaws.com/rs-professional-services-publishing/cassandra/cassandra20-2.0.10-1.noarch.rpm"
default[:cassandra][:version_rpm]      = "cassandra20-2.0.10-1.noarch.rpm"

default[:cassandra][:datastax]         = "https://s3.amazonaws.com/rs-professional-services-publishing/cassandra/dsc20-2.0.10-1.noarch.rpm"
default[:cassandra][:datastax_rpm]     = "dsc20-2.0.10-1.noarch.rpm"

default[:cassandra][:jre]              = "http://rs-professional-services-publishing.s3.amazonaws.com/cassandra/jre-7u45-linux-x64.rpm"
default[:cassandra][:jre_rpm]          = "jre-7u45-linux-x64.rpm"

default[:cassandra][:us_export_policy] = "https://rs-professional-services-publishing.s3.amazonaws.com/cassandra/US_export_policy.jar"
default[:cassandra][:local_policy]     = "https://rs-professional-services-publishing.s3.amazonaws.com/cassandra/local_policy.jar"
