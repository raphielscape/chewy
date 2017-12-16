#!/usr/bin/env bash

source "chewy/scripts/env.sh";
setperf

# Kernel compiling script

function check_toolchain() {

    export TC="$(find ${TOOLCHAIN}/bin -type f -name *-gcc)";

	if [[ -f "${TC}" ]]; then
		export CROSS_COMPILE="${TOOLCHAIN}/bin/$(echo ${TC} | awk -F '/' '{print $NF'} |\
sed -e 's/gcc//')";
		echo -e "Using toolchain: $(${CROSS_COMPILE}gcc --version | head -1)";
	else
		echo -e "No suitable toolchain found in ${TOOLCHAIN}";
		exit 1;
	fi
}

if [[ -z ${KERNELDIR} ]]; then
    echo -e "Please set KERNELDIR";
    exit 1;
fi

export DEVICE=$1;
if [[ -z ${DEVICE} ]]; then
    export DEVICE="mido";
fi

export SRCDIR="${KERNELDIR}/${DEVICE}";
export OUTDIR="${KERNELDIR}/out";
export ANYKERNEL="${KERNELDIR}/chewy/anykernel/";
export ARCH="arm64";
export SUBARCH="arm64";
export KBUILD_BUILD_USER="alamo"
export KBUILD_BUILD_HOST="fluffycloud"
export TOOLCHAIN="${HOME}/GNU/GCC7/";
export DEFCONFIG="chewy_defconfig";
export ZIP_DIR="${KERNELDIR}/chewy/files/";
export IMAGE="${OUTDIR}/arch/${ARCH}/boot/Image.gz-dtb";

if [[ -z "${JOBS}" ]]; then
    export JOBS="$(grep -c '^processor' /proc/cpuinfo)";
fi

export MAKE="make O=${OUTDIR}";
check_toolchain;

export TCVERSION1="$(${CROSS_COMPILE}gcc --version | head -1 |\
awk -F '(' '{print $2}' | awk '{print tolower($1)}')"
export TCVERSION2="$(${CROSS_COMPILE}gcc --version | head -1 |\
awk -F ')' '{print $2}' | awk '{print tolower($1)}')"
export ZIPNAME="chewy-${TCVERSION1}.${TCVERSION2}-${DEVICE}-$(date +%Y%m%d-%H%M).zip"
export FINAL_ZIP="${ZIP_DIR}/${ZIPNAME}"

[ ! -d "${ZIP_DIR}" ] && mkdir -pv ${ZIP_DIR}
[ ! -d "${OUTDIR}" ] && mkdir -pv ${OUTDIR}

cd "${SRCDIR}";
rm -fv ${IMAGE};

if [[ "$@" =~ "mrproper" ]]; then
    ${MAKE} mrproper
fi

if [[ "$@" =~ "clean" ]]; then
    ${MAKE} clean
fi

${MAKE} $DEFCONFIG;
START=$(date +"%s");
echo -e "Using ${JOBS} threads to compile"
${MAKE} -j${JOBS};
exitCode="$?";
END=$(date +"%s")
DIFF=$(($END - $START))
echo -e "Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.";


if [[ ! -f "${IMAGE}" ]]; then
    echo -e "Build failed :P";
    success=false;
    exit 1;
else
    echo -e "Build Succesful!";
    success=true;
fi

echo -e "Copying kernel image";
cp -v "${IMAGE}" "${ANYKERNEL}/";
cd -;
cd ${ANYKERNEL};
zip -r9 ${FINAL_ZIP} *;
cd -;

if [ -f "$FINAL_ZIP" ];
then
echo -e "$ZIPNAME zip can be found at $FINAL_ZIP";
if [[ ${success} == true ]]; then
    echo -e "Uploading ${ZIPNAME} to https://transfer.sh/";
    transfer "${FINAL_ZIP}";
fi
else
echo -e "Zip Creation Failed =(";
fi
