#
# Cookbook Name:: cassandra
#
# Copyright 2013, RightScale
#
# All rights reserved - Do Not Redistribute
#

default[:cassandra][:version]          = "https://s3.amazonaws.com/rs-professional-services-publishing/cassandra/cassandra20-2.0.10-1.noarch.rpm"
default[:cassandra][:version_rpm]      = "cassandra20-2.0.10-1.noarch.rpm"
default[:version_rpm][:checksum]       = "b58688c10e360cd56edc92be7696f924ac3c8eb63ed30c348d68fdfb7b4526ce"

default[:cassandra][:datastax]         = "https://s3.amazonaws.com/rs-professional-services-publishing/cassandra/dsc20-2.0.10-1.noarch.rpm"
default[:cassandra][:datastax_rpm]     = "dsc20-2.0.10-1.noarch.rpm"
default[:datastax_rpm][:checksum]      = "e170a5236397ad37d94d833668c8a747331a1fa1a56de345b06c9ef3a8ea8196"

default[:cassandra][:jre]              = "http://rs-professional-services-publishing.s3.amazonaws.com/cassandra/jre-7u45-linux-x64.rpm"
default[:cassandra][:jre_rpm]          = "jre-7u45-linux-x64.rpm"
default[:jre_rpm][:checksum]           "b3d28c3415cffd965a63cd789d945cf9da827d960525537cc0b10c6c6a98221a"

default[:cassandra][:us_export_policy] = "https://rs-professional-services-publishing.s3.amazonaws.com/cassandra/US_export_policy.jar"
default[:cassandra][:local_policy]     = "https://rs-professional-services-publishing.s3.amazonaws.com/cassandra/local_policy.jar"
