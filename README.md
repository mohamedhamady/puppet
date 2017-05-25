# Install and configure puppet

## Create vagrant machines
see vagrant file

## install basic tools

```bash

vagrant ssh pm
sudo yum -y install vim git ntp
sudo chkconfig ntpd on
sudo service ntpd start
```

### Install puppetserver

```bash

sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum -y  install puppetserver
puppet master --version
sudo chkconfig puppetserver on
sudo service puppetserver start
```


### configuration

- Create envs dirs

```bash
  sudo mkidr -p /etc/puppet/environments/production/{modules,manifests}

```

- Change /etc/puppet/puppet.conf

```ini

[main]
    dns_alt_names = puppet,pm,puppetmaster

[master]
    environementpath = $confdir/environments
    basemodulepath = $confdir/modules:/opt/puppet/share/modules

```

- Disable selinux

```bash

sudo setenforce permissive
sudo getenforce
sudo sed -i 's/=disabled/=permissive/g' /etc/sysconfig/selinux
or
sudo sed -i 's/=enforcing/=permissive/g' /etc/sysconfig/selinux
```

- Iptables

```bash
# add this rule
-A INPUT -m state --state NEW -m tcp -p tcp --dport 8140 -j ACCEPT
sudo service iptables restart
```

- Generating certifs:
```bash

sudo puppet master --verbose --no-daemonize # (only for the first run)
sudo ls -l /var/lib/puppet/ssl   # Check if certifs are well generated
```

# Configure  nodes

##  node wiki
### install puppet agent

```bash

sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum -y  install puppet
```

### specify pm node

```bash
sudo -i 
echo 192.168.2.10 pm >> /etc/hosts
```

edit /etc/puppet/puppet.conf
server = pm

- Certs request
sudo puppet agent --verbose --no-daemonize --onetime

- Go to pm and sign cert for wiki node

```bash
puppet cert list
puppet cert sign wiki
```

- go back to wiki node and check

sudo puppet agent --verbose --no-daemonize --onetime

## Puppet codes
- create /etc/puppet/environments/production/manifests/nodes.pp
- add basic puppet code (see nodes-v1.pp)
- go back to wiki and execute puppet agent -t (for test)

