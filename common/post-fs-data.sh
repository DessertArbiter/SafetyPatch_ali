#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
sed 's/ORANGE/GREEN/i' /proc/cmdline | sed 's/YELLOW/GREEN/i' > /data/local/tmp/cmdline
mount -o bind /data/local/tmp/cmdline /proc/cmdline

sed 's;^ro.*\.build\.fingerprint=.*;ro.build.fingerprint=motorola/ali/ali:9/PPSS29.55-37-4-3/f1bdc:user/release-keys;' /system/build.prop > /data/local/tmp/build.prop
mount -o bind /data/local/tmp/build.prop /system/build.prop
# The build.prop thing seems to be useless, but at some point Google are sure to catch on and check in the raw build.prop to see if we're abusing getprop/resetprop.

resetprop ro.build.fingerprint 'motorola/ali/ali:9/PPSS29.55-37-4-3/f1bdc:user/release-keys'
resetprop ro.bootimage.build.fingerprint 'motorola/ali/ali_retail:9/PPSS29.55-37-4-3/f1bdc:user/release-keys'
