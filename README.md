# My Scripts
Miscellaneous scripts and other stuff about Linux systems

# Useful commands
## Free swap
Since this command move all swap content to RAM enough free space is needed
```
$ sudo swapoff -a ; sudo swapon -a
```
## Disable ipv6
**Ubuntu**
1. Add the following 3 lines to `/etc/sysctl.conf`
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
```
2. Reload the `sysctl.conf`
```
$ sudo sysctl --load
```

If you want to know if IPv6 is disable, the following command must return 1.
```
$ cat /proc/sys/net/ipv6/conf/all/disable_ipv6
```
