#!/sbin/sh
echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo " # Default Frequency and Governor" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 2016000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo bfq > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo " # Graphic Processing Unit Parameters" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 133000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 650000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo " # This commandlines enable ZRAM functions lol" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " swapoff /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 1 > /sys/block/zram0/reset" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " echo 1073741824 > /sys/block/zram0/disksize" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " mkswap /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo " swapon /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

