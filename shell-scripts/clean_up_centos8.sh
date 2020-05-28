#!/usr/bin/env bash
# Based off the great "Preparing Linux Template VMs" and centos-vmware-vcloud_cleanup.sh
# sys-unconfig on Centos 8
# (http://lonesysadmin.net/2013/03/26/preparing-linux-template-vms/) article
# (https://github.com/frapposelli/packer-templates/blob/master/scripts/centos-vmware-vcloud_cleanup.sh) repository

 echo "==> Cleaning up yum cache"
 /usr/bin/yum clean all

 echo "==> Force logs to rotate and clear old"
 /usr/sbin/logrotate -f /etc/logrotate.conf
 /bin/rm -f /var/log/*-20* /var/log/*.gz

 echo "==> Clear the audit log & wtmp"
 /bin/cat /dev/null > /var/log/audit/audit.log
 /bin/cat /dev/null > /var/log/wtmp

 echo "==> Cleaning up udev rules"
 /bin/rm -f /etc/udev/rules.d/70*

 echo "==> Remove the traces of the template MAC address and UUIDs"
 /bin/sed -i '/^\(HWADDR\|UUID\|IPADDR\|NETMASK\|GATEWAY\)=/d' /etc/sysconfig/network-scripts/ifcfg-e*

 echo "==> Cleaning up tmp"
 /bin/rm -rf /tmp/*
 /bin/rm -rf /var/tmp/*

 echo "==> Remove the SSH host keys"
 /bin/rm -f /etc/ssh/*key*
 rm -v /root/.ssh/known_hosts

 echo "==> Remove the root user’s shell history"
 /bin/rm -f /root/.bash_history
 unset HISTFILE

 echo "==> Set hostname to localhost"
 /bin/sed -i "s/HOSTNAME=.*/HOSTNAME=localhost.localdomain/g" /etc/sysconfig/network
 /bin/hostnamectl set-hostname localhost.localdomain

 echo "==> Remove rsyslog.conf remote log server IP"
 /bin/sed -i '/1.1.1.1.1/'d /etc/rsyslog.conf

 echo "==> Clear out the osad-auth.conf file to stop dupliate IDs"
 rm -v /etc/sysconfig/rhn/osad-auth.conf
 rm -v /etc/sysconfig/rhn/systemid

 echo "==> Shutdown the VM. Poweron required to scan new HW addresses."
 poweroff