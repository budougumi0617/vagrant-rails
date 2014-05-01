# Vagrantfile with CentOS 6.5/ruby 2.1.1/rails 4.1.0

_Description: Vagrantfile with CentOS 6.5/ruby 2.1.1/rails 4.1.0

## Project Setup

1. Download and install Vagrant [http://www.vagrantup.com/](http://www.vagrantup.com/)

2. `vagrant plugin install vagrant-omnibus`

3. Download and install VirtualBox [https://www.virtualbox.org/](https://www.virtualbox.org/)

4. `git clone https://github.com/morizyun/vagrant-rails`

5. `cd vagrant-rails`

6. `bundle install`

7. `bundle exec berks install --path site-cookbooks`

8. `vagrant up`



```
vagrant ssh
cd /vagrant/app
rails new helloWorld
cd helloWorld
echo "gem 'therubyracer', platforms: :ruby" >> Gemfile
bundle install
bundle exec rake db:create
sudo vi  /etc/sysconfig/iptables
sudo service iptables restart
rails s
```

You need to edit file by `sudo vi  /etc/sysconfig/iptables`.
Editted file was bellow:

```
cat  /etc/sysconfig/iptables
[vagrant@localhost helloWorld]$ sudo cat /etc/sysconfig/iptables
# Firewall configuration written by system-config-firewall
# Manual customization of this file is not recommended.
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 3000 -j ACCEPT #Add setting
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
```

**Browsing** [http://192.168.33.10/](http://192.168.33.10/)

## Basic information

1. Sync Folder(Sever - Local) : `/vagrant/app` - `app/`


## Appendix
[http://morizyun.github.io/blog/vagrant-centos-nginx-mysql-rbenv/](http://morizyun.github.io/blog/vagrant-centos-nginx-mysql-rbenv/)
