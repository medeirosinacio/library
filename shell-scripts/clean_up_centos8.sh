#!/usr/bin/env bash

 #
 # This is the sys_prep script
 # It will clear out all non-revelent information for a new VM
 #
 # 1. Force logs to rotate and clear old.
 /usr/sbin/logrotate -f /etc/logrotate.conf
 /bin/rm -f /var/log/*-20* /var/log/*.gz
 #
 # 2. Clear the audit log & wtmp.
 /bin/cat /dev/null > /var/log/audit/audit.log
 /bin/cat /dev/null > /var/log/wtmp
 #
 # 3. Remove the udev device rules.
 /bin/rm -f /etc/udev/rules.d/70*
 #
 # 4. Remove the traces of the template MAC address and UUIDs.
 /bin/sed -i '/^\(HWADDR\|UUID\|IPADDR\|NETMASK\|GATEWAY\)=/d' /etc/sysconfig/network-scripts/ifcfg-e*
 #
 # 5. Clean /tmp out.
 /bin/rm -rf /tmp/*
 /bin/rm -rf /var/tmp/*
 #
 # 6. Remove the SSH host keys.
 /bin/rm -f /etc/ssh/*key*
 #
 # 7. Remove the root user's shell history.
 /bin/rm -f /root/.bash_history
 unset HISTFILE
 #
 # 8. Set hostname to localhost
 /bin/sed -i "s/HOSTNAME=.*/HOSTNAME=localhost.localdomain/g" /etc/sysconfig/network
 /bin/hostnamectl set-hostname localhost.localdomain

 #
 # 9. Remove rsyslog.conf remote log server IP.
 /bin/sed -i '/1.1.1.1.1/'d /etc/rsyslog.conf

 # 10. Clear out the osad-auth.conf file to stop dupliate IDs
 #
 rm -v /etc/sysconfig/rhn/osad-auth.conf
 rm -v /etc/sysconfig/rhn/systemid


 # clean hosts
 #hostname_check=$(hostname)
 #if ! [[ "${hostname_check}" =~ "local" ]]; then
 #	cp -v /etc/hosts /etc/hosts.sys_prep
 #	sed -i "s,$(hostname),,g" /etc/hosts
 #	sed -i "s,$(hostname -s),,g" /etc/hosts
 #fi

 rm -v /root/.ssh/known_hosts

 #
 # 11. Shutdown the VM. Poweron required to scan new HW addresses.
 poweroff