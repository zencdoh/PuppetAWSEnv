## <font color='blue'>AWS Infrastructure Provisioning through puppet</font>

### UseCase: 
<p>Script should create security groups,three instances (web,app,db) and a load balancer.</p>
<p>Considering that puppet master is up and running.</p>

### 1.Configuration:

- gem install aws-sdk-core gem install retries
- Once the gems are installed, restart Puppet Server.
- service puppetmaster restart
- export AWS_ACCESS_KEY_ID= 
- export AWS_SECRET_ACCESS_KEY=
- export AWS_REGION=us-west-2
- puppet module install puppetlabs-aws

### 2.Scripting:

- Go to aws module directory.<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cd /etc/puppet/modules/aws/tests/</p>
- Write a infra provisioning script.<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nano demo_create_all.pp</p>
- Write a infra deletion script.<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nano demo_delete_all.pp</p>

### 3.Applying Configurations:

- Go to tests directory of aws module and execute below command for creating infrastructure on aws cloud:<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;puppet apply demo_create_all.pp</p>
- To delete infrastructure that is created execute below command:
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;puppet apply demo_delete_all.pp</p>

### 4.Verifying the Configurations:

- Login to aws managenent console
- Change the region to Oregon(As we mentioned us-west-2 you can change region according your requirement).
- Instances will be visible at EC2 Dashboard.
- Security groups are visible under Network and Security section.
- Load balancer at Loadbalancing section.



