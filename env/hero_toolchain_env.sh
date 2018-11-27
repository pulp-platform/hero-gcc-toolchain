#! /bin/bash
# Copyright (C) 2018 ETH Zurich and University of Bologna
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Authors: Alessandro Capotondi, University of Bologna (alessandro.capotondi@unibo.it)
#
# This environmental variables for the HERO GCC 7.1.1 toolchain

# HERO build target
HERO_TOOLCHAIN_BUILD_TARGET=x86_64-linux-gnu

# HERO host configuration
HERO_TOOLCHAIN_HOST_TARGET=arm-linux-gnueabihf
HERO_TOOLCHAIN_HOST_LINUX_ARCH=arm
HERO_TOOLCHAIN_HOST_GLIBC=glibc-2.26
HERO_TOOLCHAIN_HOST_FPU_CONFIG="--with-fpu=neon-fp16 --with-float=hard"

# HERO accelerator configuration
HERO_TOOLCHAIN_ACCEL_TARGET=riscv32-unknown-elf

# Script Return value
RET=0

if [[ ! ${HERO_TOOLCHAIN_DIR+x} ]]; then
  HERO_TOOLCHAIN_DIR=`readlink -f .`
fi

HERO_TOOLCHAIN_PKG_DIR=`readlink -f ${HERO_TOOLCHAIN_DIR}/pkg`
if [ ! -d "${HERO_TOOLCHAIN_PKG_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_PKG_DIR}
fi

HERO_TOOLCHAIN_INSTALL_DIR=`readlink -f ${HERO_TOOLCHAIN_PKG_DIR}/hero-gcc-toolchain`
if [ ! -d "${HERO_TOOLCHAIN_INSTALL_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_INSTALL_DIR}
fi

HERO_TOOLCHAIN_BUILD_DIR=`readlink -f ${HERO_TOOLCHAIN_PKG_DIR}/build`
if [ ! -d "${HERO_TOOLCHAIN_BUILD_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_BUILD_DIR}
fi

HERO_TOOLCHAIN_SRC_DIR=`readlink -f ${HERO_TOOLCHAIN_DIR}/src`
if [ ! -d "${HERO_TOOLCHAIN_SRC_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_SRC_DIR}
fi

HERO_TOOLCHAIN_GCC_SRC_DIR=`readlink -f ${HERO_TOOLCHAIN_SRC_DIR}/riscv-gcc`
if [ ! -d "${HERO_TOOLCHAIN_GCC_SRC_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_GCC_SRC_DIR}
fi

HERO_TOOLCHAIN_HOST_GCC_BUILD_DIR=`readlink -f ${HERO_TOOLCHAIN_BUILD_DIR}/${HERO_TOOLCHAIN_HOST_TARGET}`
if [ ! -d "${HERO_TOOLCHAIN_HOST_GCC_BUILD_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_HOST_GCC_BUILD_DIR}
fi

HERO_TOOLCHAIN_ACCEL_GCC_BUILD_DIR=`readlink -f ${HERO_TOOLCHAIN_BUILD_DIR}/${HERO_TOOLCHAIN_ACCEL_TARGET}`
if [ ! -d "${HERO_TOOLCHAIN_ACCEL_GCC_BUILD_DIR}" ]; then
  mkdir -p ${HERO_TOOLCHAIN_ACCEL_GCC_BUILD_DIR}
fi

export PULP_RISCV_GCC_TOOLCHAIN="${HERO_TOOLCHAIN_INSTALL_DIR}"

if [ -z "${HERO_LINUX_KERNEL_DIR}" ]; then
  echo "Warning: missing environment variable HERO_LINUX_KERNEL_DIR!" >&2
else
  HERO_HOST_LINUX_KERNEL_DIR=${HERO_LINUX_KERNEL_DIR}  
  echo "Setting up Linux Kernel Directory."
fi

if [ -z "${PULP_SDK_INSTALL}" ] || [ -z "${HERO_SUPPORT_DIR}" ] ; then
  echo "Warning: cannot set compiler and linker flags for libgomp plugin and mkoffload. Missing environment variables PULP_SDK_INSTALL and/or HERO_SUPPORT_DIR!" >&2
else
  echo "Setting up compiler and linker flags for libgomp plugin and mkoffload."

  # GCC PULP HERO libgomp plugin compilation flags
  export LIBGOMP_PLUGIN_PULP_HERO_CPPFLAGS="-O3 -Wall -g2 -shared -fPIC -I${HERO_SUPPORT_DIR}/libpulp/inc -I${PULP_SDK_INSTALL}/include/archi/chips/bigpulp -I${PULP_SDK_INSTALL}/include -DPLATFORM=${PLATFORM}"
  export LIBGOMP_PLUGIN_PULP_HERO_LDFLAGS="-L${HERO_SUPPORT_DIR}/libpulp/lib -lpulp -lstdc++"

  # HERO MKOFFLOAD external compilation flags
  export PULP_HERO_EXTCFLAGS="-march=rv32imcxpulpv2 -D__riscv__ -DPLATFORM=${PLATFORM} -Wextra -Wall -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -Wundef -fdata-sections -ffunction-sections -I${PULP_SDK_INSTALL}/include/io -I${PULP_SDK_INSTALL}/include"

  export PULP_HERO_EXTLDFLAGS="${PULP_SDK_INSTALL}/hero/hero-z-7045/rt_conf.o ${PULP_SDK_INSTALL}/lib/hero-z-7045/rt/crt0.o -nostartfiles -nostdlib -Wl,--gc-sections -T${PULP_SDK_INSTALL}/hero/hero-z-7045/test.ld -T${PULP_SDK_INSTALL}/hero/hero-z-7045/test_config.ld -L${PULP_SDK_INSTALL}/lib/hero-z-7045 -lgomp -lrt -lrtio -lrt -lhero-target -lvmm -larchi_host -lrt -larchi_host -lgcc -lbench -lm"
fi

if [[ ":$PATH:" != *":${HERO_TOOLCHAIN_INSTALL_DIR}/bin:"* ]]; then
  export PATH="${HERO_TOOLCHAIN_INSTALL_DIR}/bin":${PATH}
fi

if [[ ":$LD_LIBRARY_PATH:" != *":${HERO_TOOLCHAIN_INSTALL_DIR}/lib:"* ]]; then
  export LD_LIBRARY_PATH="${HERO_TOOLCHAIN_INSTALL_DIR}/lib":${LD_LIBRARY_PATH}
fi

return $RET

# That's all folks!!
