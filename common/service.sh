#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
LOGFILE=/cache/magisk.log
MODNAME=${MODDIR#/magisk/}
MOUNTPOINT=/magisk
COREDIR=$MOUNTPOINT/.core
buildname="custom_build.prop"
SCRIPTLIST=`find $MODDIR/script -maxdepth 1 -type f ! -name "99dnscrypt" 2>/dev/null | sort -d`

RESETPROP="/data/magisk/resetprop"
if [ -f "$COREDIR/bin/resetprop" ]; then
  RESETPROP="$COREDIR/bin/resetprop"
fi

log_print() {
  echo "$MODNAME: $1"
  echo "$MODNAME: $1" >> $LOGFILE
  log -p i -t "$MODNAME" "$1"
}

# This script will be executed in late_start service mode
# More info in the main Magisk thread

if [ ! -z "$SCRIPTLIST" ]; then
  for ITEM in $SCRIPTLIST; do
    log_print "running script $ITEM"
    chmod 755 "$ITEM"
    /system/bin/sh "$ITEM" &
  done
else
  chmod 755 $MODDIR/script/99dnscrypt
  log_print "starting dnscypt"
  /system/bin/sh "$MODDIR/script/99dnscrypt" &
fi

"$RESETPROP" 'net.dns1' '127.0.0.1﻿'
# "$RESETPROP" --file "$MODDIR/$buildname"
