# This will create a set of instances, load balancers and security groups in the
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

ec2_securitygroup { 'sec_grp_lb':
  ensure      => present,
  description => 'Security group for load balancer',
  ingress     => [{
    protocol => 'tcp',
    port     => 80,
    cidr     => '0.0.0.0/0'
  }],
}

ec2_securitygroup { 'sec_grp_web_svr':
  ensure      => present,
  description => 'Security group for web servers',
  ingress     => [{
    security_group => 'sec_grp_lb',
  },{
    protocol => 'tcp',
    port     => 22,
    cidr     => '0.0.0.0/0'
  }],
}

ec2_securitygroup { 'sec_grp_db_svr':
  ensure      => present,
  description => 'Security group for database servers',
  ingress     => [{
    security_group => 'sec_grp_web_svr',
  },{
    protocol => 'tcp',
    port     => 22,
    cidr     => '0.0.0.0/0'
  }],
}

ec2_instance { ['web_svr', 'app_svr']:
  ensure          => present,
  image_id        => 'ami-7c22b41c', # EU 'ami-b8c41ccf',
  security_groups => ['sec_grp_web_svr'],
  instance_type   => 't2.micro',
  key_name => 'test00',
  subnet => 'subnet-bff7efdb',
  tags            => {
    department => 'hybridit',
    project    => 'cloud',
    created_by => $::id,
  }
}

ec2_instance { 'db_svr':
  ensure          => present,
  image_id        => 'ami-7c22b41c', # EU 'ami-b8c41ccf',
  security_groups => ['sec_grp_db_svr'],
  instance_type   => 't2.micro',
  subnet => 'subnet-bff7efdb',
  tags            => {
    department => 'hybridit',
    project    => 'cloud',
    created_by => $::id,
  },
  block_devices => [
    {
      device_name => '/dev/sda1',
      volume_size => 8,
    }
  ]
}

elb_loadbalancer { 'loadbaldemo':
  ensure             => present,
  availability_zones => ['us-west-2a'],
  instances          => ['web_svr', 'app_svr'],
  listeners          => [{
    protocol           => 'tcp',
    load_balancer_port => 80,
    instance_protocol  => 'tcp',
    instance_port      => 80,
  }],
}

