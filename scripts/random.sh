#!/bin/bash
RANDOM_FILES="include/uapi/linux/random.h include/linux/random.h include/trace/events/random.h drivers/char/random.c lib/random32.c"

rm -f $RANDOM_FILES;
for files in $RANDOM_FILES; do
wget -O $files https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/plain/$files?h=linux-4.1.y;
done;
sed -i 's/[[:space:]]*$//' $RANDOM_FILES;