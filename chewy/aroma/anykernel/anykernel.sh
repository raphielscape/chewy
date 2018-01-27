# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=raphielscape @ telegram lol
do.devicecheck=0
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
} # end properties 

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
mount /system;
mount -o remount,rw /system;
chmod -R 755 $ramdisk

## AnyKernel install
dump_boot;

# begin ramdisk changes

# add inferno initialization script
insert_line init.rc "import /init.chewy.rc" after "import /init.environ.rc" ;
insert_line init.rc "import /init.spectrum.rc" after "import /init.trace.rc" "import /init.spectrum.rc";
cp -rpf $patch/thermal-engine.conf /system/etc/thermal-engine.conf

#remove deprecated ipv6 rmnet entries
remove_line init.qcom.rc "    #To allow interfaces to get v6 address when tethering is enabled"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet0/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet0/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet1/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet2/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet3/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet4/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet5/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet6/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet7/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio0/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio1/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio2/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio3/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio4/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio5/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio6/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_sdio7/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_usb0/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_usb1/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_usb2/accept_ra 2"
remove_line init.qcom.rc "    write /proc/sys/net/ipv6/conf/rmnet_usb3/accept_ra 2"

# end ramdisk changes

write_boot;

## end install

