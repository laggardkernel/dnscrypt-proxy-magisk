# DNSCrypt for Android

### DNSCrypt

DNSCrypt is a protocol that authenticates communications between a DNS client and a DNS resolver. It prevents DNS spoofing. It uses cryptographic signatures to verify that responses originate from the chosen DNS resolver and haven't been tampered with.

It is an open specification, with free and opensource reference implementations, and it is not affiliated with any company nor organization.

### Installing a DNSCrypt client

DNSCrypt itself is not a product, but a protocol that anyone can implement. Portable implementations are also available, on top on which graphical user interfaces and convenient tools have been built.

DNSCrypt-proxy v2 is the defacto standard for DNScrypt, DNS over TLS, and other standards. DNSCrypt-proxy can be found [here](https://dnscrypt.info/)

Firewall setup: although some resolvers may prefer a different port, the default port used by the DNSCrypt protocol is 443. Outgoing queries to this port on both TCP and UDP should be allowed by your firewall.

### DNSCrypt for Android

Running DNSCrypt on Android currently requires a rooted device. If you don't know how to root an Android device, the [xda-developers forum](http://forum.xda-developers.com/) is a good place to start.

dnscrypt-proxy provides an Android package, however it does not have any wrapper and requires manual installation. This program is a [Magisk](https://forum.xda-developers.com/apps/magisk/official-magisk-v7-universal-systemless-t3473445) wrapper for dnscrypt-proxy. This provides the binaries provided by dnscrypt-proxy in a magisk module that can be installed on a rooted Android phone. 

### Magisk Version Installation

- Install [Magisk - Root & Universal Systemless Interface \[Android 5.0+\]](https://forum.xda-developers.com/apps/magisk/official-magisk-v7-universal-systemless-t3473445).
- [Download the zip](https://github.com/cool00geek/dnscrypt-proxy-magisk/releases) and flash it in Magisk Manager or in Recovery.
- zip file includes four architectures: arm, arm64, x86, x64.
- Script in `/magisk/dnscrypt-proxy/script`, default `99dnscrypt`, will be excuted to start dnscrypt-proxy as init script. If other scripts exist there, `99dnscrypt` will be ignored.
- Once installed and activated, run `dnscrypt enable` from a superuser shell (By typing `su` in a terminal or `adb shell`)


### Credit

- [jedisct1](https://github.com/jedisct1), creator of [DNSCrypt](https://github.com/jedisct1/dnscrypt-proxy).
- [laggardkernel](https://github.com/laggardkernel/dnscrypt-proxy-magisk) for the original DNSCrypt-Proxy Magisk module

### Issues/Contributing

As a part of the Open Source community, if you have any changes, don't be afraid to implement them and create a pull request! 

Otherwise, feel free to create an issue to monitor and help make this module better!
