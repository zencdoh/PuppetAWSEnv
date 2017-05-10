# This will destroy a set of instances, load balancers and security groups in the
# specified AWS region.

Ec2_securitygroup {
  region => 'us-west-2',
}

Ec2_instance {
  region            => 'us-west-2',
  availability_zone => 'us-west-2a',
}

Elb_loadbalancer {
  region => 'us-west-2',
}

elb_loadbalancer { 'loadbaldemo':
  ensure => absent,
} ~>
ec2_instance { ['web_svr', 'app_svr', 'db_svr']:
  ensure => absent,
} ~>
ec2_securitygroup { 'sec_grp_db_svr':
    ensure => absent,
} ~>
ec2_securitygroup { 'sec_grp_web_svr':
    ensure => absent,
} ~>
ec2_securitygroup { 'sec_grp_lb':
    ensure => absent,
}
