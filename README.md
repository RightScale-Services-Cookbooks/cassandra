cassandra Cookbook
==================
This cookbook will install DataStax Community Edition 2.0.10.


Usage
-----
`cassandra::install`

This will download and install Cassandra, Oracle Java and set some [recommended settings](http://www.datastax.com/documentation/cassandra/1.2/cassandra/install/installRecommendSettings.html).

`cassandra::configure`

This will install the cassandra.yaml configuration file and start Cassandra. This script needs to be manually run on each node one at a time.

All hosts which will be used as seed nodes need to be booted and running before any configure script is run. This script uses RightScale tags to discover all seed hosts in the Cassandra ring and will write out these IP addresses to the cassandra.yaml file the host when this script is run.


Attributes
----------

`cassandra/cluster_name`: This is the name of the Cassandra ring.

`cassandra/is_seed_host`: Set this value to true if this host is to be used for new node discovery.

`cassandra/listen_address`: Address to bind to and tell other Cassandra nodes to connect to.

`cassandra/broadcast_address`: Address to broadcast to other Cassandra nodes.

`cassandra/commitlog_directory`: Directory where commitlog data will be stored

`cassandra/data_file_directories`: Comma separated list of where Cassandra data files will be stored.

`cassandra/saved_caches_directory`: Directory where saved cache data will be stored.

`cassandra/require_inter_node_encryption`: Enable or disable inter-node encryption. If using inter-node encryption keystore and truststore must be first created and uploaded so that each node can install these files at configuration time. Instructions on how to do this is documented [here](http://download.oracle.com/javase/6/docs/technotes/guides/security/jsse/JSSERefGuide.html#CreateKeystore
)

`cassandra/encryption_password`: Password used for the keystore.

`cassandra/authenticator`: Authentication backend to use.

`cassandra/authorizer`: Authorization backend to use.

`cassandra/bucket`: Bucket where keystore / truststore is stored.

`cassandra/provider`: Provider where keystore / truststore is stored (S3 or CloudFiles).

`cassandra/storage_account_id`: Account ID key to use to download keystore / truststore files.

`cassandra/storage_account_secret`: Secret key to used to download keystore / truststore files.

`cassandra/truststore`: Location where truststore file is to be downloaded from.

`cassandra/keystore`: Location where keystore file is to be downloaded from.
