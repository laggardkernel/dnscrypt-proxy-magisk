#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
LOGFILE=/cache/magisk.log
MODNAME=${MODDIR#/magisk/}
MOUNTPOINT=/magisk
COREDIR=$MOUNTPOINT/.core

MODE="post-fs-data"
APKNAME=*.apk
PACKAGENAME=*.*.*

SEPOLICY="/data/magisk/sepolicy-inject"
if [ -f $COREDIR/bin/magiskpolicy ]; then
  SEPOLICY="$COREDIR/bin/magiskpolicy"
elif [ -f /data/magisk/magiskpolicy ]; then
  SEPOLICY="/data/magisk/magiskpolicy"
fi

# Use the included busybox for maximum compatibility and reliable results
# e.g. we rely on the option "-c" for cp (reserve contexts), and -exec for find
if [ -d "/dev/busybox" ]; then
  TOOLPATH=/dev/busybox
else
  TOOLPATH=/data/busybox
fi
# BINPATH=/data/magisk

log_print() {
  echo "$MODNAME: $1"
  echo "$MODNAME: $1" >> $LOGFILE
  log -p i -t "$MODNAME" "$1"
}

bind_mount() {
  if [ -e "$1" -a -e "$2" ]; then
    mount -o bind $1 $2
    if [ "$?" -eq "0" ]; then
      log_print "Mount: $1"
    else
      log_print "Mount Fail: $1"
    fi
  fi
}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

# if other su binaries exist, route them to ours
# mount -o bind $MODDIR/bin/su /sbin/su 2>/dev/null
# mount -o bind $MODDIR/bin/su /system/bin/su 2>/dev/null
# mount -o bind $MODDIR/bin/su /system/xbin/su 2>/dev/null

# bind_mount bin files to /system/bin manually
if [ -f "$MODDIR/bin_bind/enable" ]; then
  log_print "Binding binaries to bin"
  rm -rf "$MODDIR/bin_bind"
  mkdir -p "$MODDIR/bin_bind"
  touch "$MODDIR/bin_bind/enable"
  $TOOLPATH/cp -afc /system/bin/. $MODDIR/bin_bind
  # In case that you're bind_mounting your own su, uncomment below
  # rm -rf $MODDIR/bin_bind/su $MODDIR/bin_bind/sepolicy-inject 2>/dev/null
  chmod -R 755 $MODDIR/bin_bind
  chcon -hR "u:object_r:system_file:s0" $MODDIR/bin_bind
  ln -s $MODDIR/bin/* $MODDIR/bin_bind 2>/dev/null
  bind_mount $MODDIR/bin_bind /system/bin
fi

if [ -d "${MODDIR}/system/priv-app/Ax" ] || [ -d "${MODDIR}/system/priv-app/AxUI" ]; then
  log_print "set SELinux permissive"
  setenforce 0
else
  log_print "sepolicy live patch"
  # For Magisk v9
  # $SEPOLICY --live -s mediaserver -t mediaserver_tmpfs -c file -p read,write,execute
  # $SEPOLICY --live -s audioserver -t audioserver_tmpfs -c file -p read,write,execute
  # Preparation for Magisk v11+ with the new MagiskSU and its sepolicy
  $SEPOLICY --live "allow mediaserver mediaserver_tmpfs file { read write execute }" \
  "allow audioserver audioserver_tmpfs file { read write execute }"
fi
