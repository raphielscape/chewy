#!/sbin/sh

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # Minimum Global Frequency" >> /system/vendor/bin/init.qcom.post_boot.sh
cpu0=`grep selected.1 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "  echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $cpu0 = 2 ]; then
echo "  echo 1036800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # Maximum Global Frequency" >> /system/vendor/bin/init.qcom.post_boot.sh
cpu0=`grep selected.2 /tmp/aroma/cpu0.prop | cut -d '=' -f2`
if [ $cpu0 = 1 ]; then
echo "  echo 2016000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $cpu0 = 2 ]; then
echo "  echo 1958400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $cpu0 = 3 ]; then
echo "  echo 1804800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo 1689600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # Setting up CPU Governors" >> /system/vendor/bin/init.qcom.post_boot.sh
gov=`grep selected.0 /tmp/aroma/gov.prop | cut -d '=' -f2`
if [ $gov = 1 ]; then
echo "  echo \"conservative\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $gov = 2 ]; then
echo "  echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $gov = 3 ]; then
echo "  echo \"ondemand\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $gov = 4 ]; then
echo "  echo \"performance\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo \"interactive\" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # Setting up IO Schedulers" >> /system/vendor/bin/init.qcom.post_boot.sh
SCHED=`grep selected.1 /tmp/aroma/sched.prop | cut -d '=' -f2`
if [ $SCHED = 1 ]; then
echo "  echo cfq > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 2 ]; then
echo "  echo deadline > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 3 ]; then
echo "  echo maple > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 4 ]; then
echo "  echo noop > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 5 ]; then
echo "  echo zen > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 6 ]; then
echo "  echo iops > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 7 ]; then
echo "  echo siops > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 8 ]; then
echo "  echo bfq > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo zen > /sys/block/mmcblk0/queue/scheduler" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "  # Readahead Tuneups" >> /system/vendor/bin/init.qcom.post_boot.sh

SCHED=`grep selected.2 /tmp/aroma/sched.prop | cut -d '=' -f2`
if [ $SCHED = 1 ]; then
echo "  echo 768 > /sys/block/mmcblk0/queue/read_ahead_kb" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $SCHED = 2 ]; then
echo "  echo 1024 > /sys/block/mmcblk0/queue/read_ahead_kb" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo 2048 > /sys/block/mmcblk0/queue/read_ahead_kb" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # KCAL " >> /system/vendor/bin/init.qcom.post_boot.sh

misc=`grep selected.1 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 2 ]; then
echo "  echo 217 215 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 265 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 253 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 250 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $misc = 3 ]; then
echo "  echo 223 223 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 271 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $misc = 4 ]; then
echo "  echo 232 237 256 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 300 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $misc = 5 ]; then
echo "  echo 230 232 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 274 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 247 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 268 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 0 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $misc = 6 ]; then
echo "  echo 232 228 255 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 251 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 254 > /sys/devices/platform/kcal_ctrl.0/kcal_val" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 256 > /sys/devices/platform/kcal_ctrl.0/kcal_cont" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 1515 > /sys/devices/platform/kcal_ctrl.0/kcal_hue" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo 256 256 256 > /sys/devices/platform/kcal_ctrl.0/kcal" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 255 > /sys/devices/platform/kcal_ctrl.0/kcal_sat" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # Vibrator" >> /system/vendor/bin/init.qcom.post_boot.sh

misc=`grep selected.2 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 1 ]; then
echo "  echo 1322 > /sys/class/timed_output/vibrator/vtg_level" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $misc = 2 ]; then
echo "  echo 1908 > /sys/class/timed_output/vibrator/vtg_level" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  echo 3045 > /sys/class/timed_output/vibrator/vtg_level" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

echo "" >> /system/vendor/bin/init.qcom.post_boot.sh

echo "  # ZRAM Triggers" >> /system/vendor/bin/init.qcom.post_boot.sh

misc=`grep selected.3 /tmp/aroma/misc.prop | cut -d '=' -f2`
if [ $misc = 1 ]; then
echo "  swapoff /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 824180736 > /sys/block/zram0/disksize" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
elif [ $misc = 2 ]; then
echo "  swapoff /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 1073741824 > /sys/block/zram0/disksize" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
else
echo "  swapoff /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 1 > /sys/block/zram0/reset" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  echo 1610612736 > /sys/block/zram0/disksize" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  mkswap /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
echo "  swapon /dev/block/zram0" >> /system/vendor/bin/init.qcom.post_boot.sh
fi

