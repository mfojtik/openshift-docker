class { 'openshift_origin' :
      #The DNS resolvable hostname of this host
      node_fqdn                  => $::fqdn,

      #The domain under which application should be created. Eg: <app>-<namespace>.example.com
      cloud_domain               => $::domain,

      #Upstream DNS server.
      dns_servers                => ['8.8.8.8'],

      enable_network_services    => true,
      configure_firewall         => true,
      configure_ntp              => true,

      #Configure the required services
      configure_activemq         => true,
      configure_mongodb          => true,
      configure_named            => true,
      configure_avahi            => false,
      configure_broker           => true,
      configure_node             => true,

      #Enable development mode for more verbose logs
      development_mode           => true,

      #Update the nameserver on this host to point at Bind server
      update_network_dns_servers => true,

      #Use the nsupdate broker plugin to register application
      broker_dns_plugin          => 'nsupdate',

      named_tsig_priv_key         => 'TSIG_KEY',
}
