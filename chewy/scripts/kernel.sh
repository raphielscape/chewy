#!/usr/bin/env bash

source "chewy/scripts/env.sh";

# Update random backport
source "scripts/random.sh";

# Kernel compiling script

if [[ -z ${KERNELDIR} ]]; then
    echo -e "Please set KERNELDIR";
    exit 1;
fi

export SRCDIR="${KERNELDIR}";
export OUTDIR="${KERNELDIR}/out";
export ANYKERNEL="${KERNELDIR}/chewy/aroma/anykernel/";
export AROMA="${KERNELDIR}/chewy/aroma/";
export ARCH="arm64";
export SUBARCH="arm64";
export KBUILD_BUILD_USER="raphielscape";
export KBUILD_BUILD_HOST="semaphorebox";

export CLANG_PATH="$HOME/CLANG/clang-4691093/bin";
export PATH="${CLANG_PATH}:${PATH}";
export CLANG_TRIPLE="aarch64-linux-gnu-";
export CLANG_TCHAIN="$HOME/CLANG/clang-4691093/bin/clang";
export KBUILD_COMPILER_STRING="$(${CLANG_TCHAIN} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')";

export TCHAIN_PATH="$HOME/GNU/GCC7/bin/aarch64-linux-android-";
export CROSS_COMPILE="${CCACHE} ${TCHAIN_PATH}";
export DEFCONFIG="mido_defconfig";
export ZIP_DIR="${KERNELDIR}/chewy/files/";
export IMAGE="${OUTDIR}/arch/${ARCH}/boot/Image.gz-dtb";

if [[ -z "${JOBS}" ]]; then
    export JOBS="$(grep -c '^processor' /proc/cpuinfo)";
#    export JOBS=64;
fi

export MAKE="make O=${OUTDIR} CC=clang";
check_toolchain;

export TCVERSION1="$(${CROSS_COMPILE}gcc --version | head -1 |\
awk -F '(' '{print $2}' | awk '{print tolower($1)}')"
export TCVERSION2="$(${CROSS_COMPILE}gcc --version | head -1 |\
awk -F ')' '{print $2}' | awk '{print tolower($1)}')"
export ZIPNAME="weeb-clang-oreo-${DEVICE}-$(date +%Y%m%d-%H%M).zip"
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

curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendSticker -d sticker="CAADBAADNwADp8uuGBHV2tl40w7WAg"  -d chat_id=@raphiel_ci;
curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="Semaphore CI build for Weeb Kernel Clang from Raphiel started, except SIGSEGV ;_;" -d chat_id=@raphiel_ci;

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
    curl -s -X POST https://api.telegram.org/bot$BOT_API_KEY/sendMessage -d text="Semaphore CI build for Weeb Kernel Clang from Raphiel stopped unexpectedly as expected, @raphielscape headsup re ;_;" -d chat_id=@raphiel_ci;
    success=false;
    exit 1;
else
    echo -e "Build Succesful!";
    success=true;
fi

echo -e "Copying kernel image";
cp -v "${IMAGE}" "${ANYKERNEL}/";
cd -;
cd ${AROMA};
zip -r9 ${FINAL_ZIP} *;
cd -;

if [ -f "$FINAL_ZIP" ];
then
echo -e "$ZIPNAME zip can be found at $FINAL_ZIP";
if [[ ${success} == true ]]; then
    echo -e "Uploading ${ZIPNAME} to https://transfer.sh/";
    transfer "${FINAL_ZIP}";
    ./chewy/scripts/deploy-tg.sh
fi
else
echo -e "Zip Creation Failed =(";
fi
