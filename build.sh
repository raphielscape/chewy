#
# Copyright © 2017, "lordarcadius" <vipuljha08@gmail.com>
# Copyright © 2017, "arn4v"
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

# Color Codes
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White


echo -e "$White***********************************************"
echo "         Compiling REVOLT Kernel             "
echo -e "***********************************************$nocol"

LC_ALL=C date +%Y-%m-%d
kernel_dir=$PWD
build=$kernel_dir/out
export CROSS_COMPILE=~/Android/kernel/tc/uu/aarch64-linux-android-7.x/bin/aarch64-linux-android-
kernel="REVOLT-EAS"
version="R2"
vendor="xiaomi"
device="mido"
zip=zip
date=`date +"%Y%m%d-%H%M"`
config=mido_defconfig
kerneltype="Image.gz-dtb"
jobcount="-j$(grep -c ^processor /proc/cpuinfo)"
#modules_dir=$kernel_dir/"$zip"/system/lib/modules
modules_dir=$kernel_dir/"$zip"/modules
zip_name="$kernel"-"$version"-"$date"-"$device".zip

# Kernel Details
BASE_AK_VER="REVOLT-EAS"
VER="R2"
AK_VER="$BASE_AK_VER$VER"

export KBUILD_BUILD_USER=NATO66613
export KBUILD_BUILD_HOST=WAR-ROM

export LOCALVERSION=~`echo $AK_VER`
echo "Checking for build..."
if [ -d arch/arm64/boot/"$kerneltype" ]; then
	read -p "Previous build found, clean working directory..(y/n)? : " cchoice
	case "$cchoice" in
		y|Y )
			rm -rf out
			mkdir out
			rm -rf "$zip"/modules
			mkdir "$zip"/modules
			export ARCH=arm64
			make clean && make mrproper
			echo "Working directory cleaned...";;
		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
	read -p "Begin build now..(y/n)? : " dchoice
	case "$dchoice" in
		y|Y)
			make "$config"
			make "$jobcount"
			exit 0;;

		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Green Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
fi
echo "Extracting files..."
if [ -f arch/arm64/boot/"$kerneltype" ]; then
	cp arch/arm64/boot/"$kerneltype" "$zip"/"$kerneltype"
#        mkdir -p zip/modules/pronto
#	cp drivers/staging/prima/wlan.ko zip/modules/pronto/pronto_wlan.ko
	find . -name '*.ko' -exec cp {} $modules_dir/ \;
	"$CROSS_COMPILE"strip --strip-unneeded "$zip"/modules/*.ko &> /dev/null
        mkdir -p zip/modules/pronto/
        mv zip/modules/wlan.ko zip/modules/pronto/pronto_wlan.ko
else
	echo "Nothing has been made..."
	read -p "Clean working directory..(y/n)? : " achoice
	case "$achoice" in
		y|Y )
                        rm -rf out
                        mkdir out
                        rm -rf "$zip"/modules
                        mkdir "$zip"/modules
			export ARCH=arm64
                        make clean && make mrproper
                        echo "Working directory cleaned...";;
		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
	read -p "Begin build now..(y/n)? : " bchoice
	case "$bchoice" in
		y|Y)
			make "$config"
			make "$jobcount"
			exit 0;;
		n|N )
			exit 0;;
		* )
			echo "Invalid...";;
	esac
fi

echo "Zipping..."
if [ -f "$zip"/"$kerneltype" ]; then
	cd "$zip"
	zip -r ../$zip_name .
	mv ../$zip_name $build
	rm "$kerneltype"
	cd ..
	rm -rf arch/arm64/boot/"$kerneltype"
	echo "Generating changelog..."
        git --no-pager log --pretty=oneline --abbrev-commit 63940662c5bd707159770d06b4db10f6ee8b73af..HEAD > zip/changelog.txt
        paste zip/changelog.txt
        #rm zip/changelog.txt
	export outdir=""$build""
        export out=""$build""
        export OUT=""$build""
	echo "$BluePackage complete: "$build"/"$zip_name"$nocol"
	exit 0;
else
	echo "No $kerneltype found..."
	exit 0;
fi
# Export script by Savoca
# Thank You Savoca!
