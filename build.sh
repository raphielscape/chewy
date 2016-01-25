#!/bin/bash
kernel_dir=$PWD
export V="v1.4"
export CONFIG_FILE="mido_defconfig"
export ARCH=arm64
export SUBARCH=arm64
export LOCALVERSION="wayang_${V}"
export KBUILD_BUILD_USER=vicatz
export KBUILD_BUILD_HOST=dalang
export TOOL_CHAIN_PATH="/home/vicatz/toolchains/linaro_gcc/aarch64-linux-gnu-7.2.1-2017.08/bin/aarch64-linux-gnu-"
export CLANG_TCHAIN="/home/vicatz/toolchains/clang/clang-4579689/bin/clang"
export CLANG_VERSION="$(${CLANG_TCHAIN} --version | head -n 1 | cut -d'(' -f1,4)"
export LD_LIBRARY_PATH="${TOOL_CHAIN_PATH}/../lib"
export PATH=$PATH:${TOOL_CHAIN_PATH}
#export out_dir="${kernel_dir}/out/"
export builddir="${kernel_dir}/zip"
#export DTBTOOL="${kernel_dir}/Dtbtool"
#export ANY_KERNEL2_DIR="${kernel_dir}/AnyKernel2"
export ZIP_NAME="wayang.zip"
export IMAGE="${out_dir}arch/arm64/boot/Image.gz-dtb";
JOBS="-j$(nproc --all)"
cd $kernel_dir
make clean && make mrproper

make_a_fucking_defconfig() {
	make $CONFIG_FILE
}

compile() {
	PATH=${BIN_FOLDER}:${PATH} make \
	O=${out_dir} \
	CC="${CLANG_TCHAIN}" \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=${TOOL_CHAIN_PATH} \
    KBUILD_COMPILER_STRING="${CLANG_VERSION}" \
	HOSTCC="${CLANG_TCHAIN}" \
    $JOBS
}

#dtb() {
#    ${DTBTOOL}/dtbToolCM -2 -o ${out_dir}arch/arm64/boot/dtb -s 2048 -p ${out_dir}scripts/dtc/ ${out_dir}arch/arm64/boot/dts/qcom/
#}

#zipit () {
#    if [[ ! -f "${IMAGE}" ]]; then
#        echo -e "Build failed :P";
#        exit 1;
#    else
#        echo -e "Build Succesful!";
#    fi
#    echo "**** Copying zImage ****"
#    cp ${out_dir}arch/arm64/boot/Image.gz ${ANY_KERNEL2_DIR}/
#    echo "**** Copying dtb ****"
#    cp ${out_dir}arch/arm64/boot/dtb ${ANY_KERNEL2_DIR}/
#
#    cd ${ANY_KERNEL2_DIR}/
#    zip -r9 ${ZIP_NAME} * -x README ${ZIP_NAME}
#    rm -rf ${kernel_dir}/Builds/${ZIP_NAME}
#    cp ${ANY_KERNEL2_DIR}/${ZIP_NAME} ${kernel_dir}/Builds/${ZIP_NAME}
#}

make_a_fucking_defconfig
compile
#dtb
#zipit
cd ${kernel_dir}
