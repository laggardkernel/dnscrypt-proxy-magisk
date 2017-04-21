# DNSCrypt for Android

### DNSCrypt

DNSCrypt is a protocol that authenticates communications between a DNS client and a DNS resolver. It prevents DNS spoofing. It uses cryptographic signatures to verify that responses originate from the chosen DNS resolver and haven't been tampered with.

It is an open specification, with free and opensource reference implementations, and it is not affiliated with any company nor organization.

### Free, DNSCrypt-enabled resolvers are available all over the world

A couple companies, organizations and individuals are operating [public recursive DNS servers supporting the DNSCrypt protocol](https://dnscrypt.org/dnscrypt-resolvers.html), so that all you need to run is a client.

A constantly updated [list of open DNSCrypt resolvers](https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv) can be downloaded to replace the default CSV file shipped with the [dnscrypt-proxy](https://dnscrypt.org/#dnscrypt-proxy) client.

If you are running your own public DNS resolver in order to help make the Internet a more secure place, please submit a [pull request](https://github.com/jedisct1/dnscrypt-proxy/pulls) to have your resolver added to the [list of public DNS resolvers](https://github.com/jedisct1/dnscrypt-proxy/blob/master/dnscrypt-resolvers.csv).

### Installing a DNSCrypt client

DNSCrypt itself is not a product, but a protocol that anyone can implement. Portable implementations are also available, on top on which graphical user interfaces and convenient tools have been built.

Choose your platform to discover some of the available options: [Windows](https://dnscrypt.org/#dnscrypt-windows) - [macOS](https://dnscrypt.org/#dnscrypt-macos) - [Linux / BSD](https://dnscrypt.org/#dnscrypt-proxy) - [Android](https://dnscrypt.org/#dnscrypt-android) - [iOS](https://dnscrypt.org/#dnscrypt-ios) or run the software on a [router](https://dnscrypt.org/#dnscrypt-routers).

Firewall setup: although some resolvers may prefer a different port, the default port used by the DNSCrypt protocol is 443. Outgoing queries to this port on both TCP and UDP should be allowed by your firewall.

### DNSCrypt for Android

Running DNSCrypt on Android currently requires a rooted device. If you don't know how to root an Android device, the [xda-developers forum](http://forum.xda-developers.com/) is a good place to start.

- Start by downloading a precompiled [dnscrypt-proxy package for Android](https://download.dnscrypt.org/dnscrypt-proxy/).
- If you want to change the DNSCrypt resolver to use, unzip the archive, edit the `RESOLVER_NAME` variable in `system/etc/init.d/99dnscrypt`. Keep the content as a ZIP file, with the original structure.
- Upload the ZIP file to the device, into `/sdcard` or any location you can write to.
- Make sure that you have a custom recovery such as TWRP or CWM. The easiest way is to download and install **TWRP Manager** from the Google Play Store. Reboot in recovery mode and install the ZIP file.
- Reboot.
- Dowload and install **Universal Init.d** from the Google Play Store. Follow the instructions until you see `Your Kernel Has init.d Support`.
- The DNSCrypt proxy should be running at this point, but your device may still use the previous DNS settings. Download and install `DNS Changer` fron the Google Play Store. In order to actually use DNSCrypt, enter `127.0.0.1` as the primary DNS resolver. In order to stop using DNSCrypt, leave this field empty.
- DNS changes may not be visible immediately. Android has its own DNS cache, and web browsers such as Chrome have another layer of DNS caching. In order to clear Chrome's DNS cache, enter `chrome://net-internals/#dns` in the URL bar, and press **Clear host cache**.

Relevant discussions:

- [Starting the daemon on Android](https://github.com/jedisct1/dnscrypt-proxy/issues/98#issuecomment-62636551)
- [How to install DNSCrypt on Android](http://forum.xda-developers.com/showthread.php?t=2793092)
- [\[GUIDE/MOD\] DNSCrypt for AArch64 (ZIP)](https://forum.xda-developers.com/nexus-5x/themes-apps/guide-dnscrypt-aarch64-t3302882) 

The dnscrypt-proxy source code can be cross-compiled for Android using the provided `dist-build/android*.sh` scripts.

It might also soon be part of the [Cyanogen Mod](https://review.cyanogenmod.org/#/q/status:open+branch:cm-12.1+topic:dnscrypt).

### Magisk Version Installation

- Install [Magisk - Root & Universal Systemless Interface \[Android 5.0+\]](https://forum.xda-developers.com/apps/magisk/official-magisk-v7-universal-systemless-t3473445).
- [Download the zip](https://github.com/laggardkernel/dnscrypt-proxy-magisk/releases) and flash it in Magisk Manager or in Recovery.
- zip file includes four architectures: arm, arm64, x86, x64.
- Script in `/magisk/dnscrypt-proxy/script`, default `99dnscrypt`, will be excuted to start dnscrypt-proxy as init script. If other scripts exist there, `99dnscrypt` will be ignored.

### Support

- [\[GUIDE/MOD\] DNSCrypt for AArch64 (ZIP)](https://forum.xda-developers.com/nexus-5x/themes-apps/guide-dnscrypt-aarch64-t3302882) 

### Credit

- [jedisct1](https://github.com/jedisct1), creator of [DNSCrypt](https://github.com/jedisct1/dnscrypt-proxy).
- [qwerty12](https://forum.xda-developers.com/member.php?u=235313), for his great [guide of compiling dnscrypt-proxy for Android](https://forum.xda-developers.com/showpost.php?p=56068030&postcount=20).
- [aschere](https://forum.xda-developers.com/member.php?u=5898631), for his updates of the AArch64 version — [\[GUIDE/MOD\] DNSCrypt for AArch64 (ZIP)](https://forum.xda-developers.com/nexus-5x/themes-apps/guide-dnscrypt-aarch64-t3302882).
