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
# This environmental variables for the GCC 5.2.0 toolchain for the HERO accelerator

HERO_HOST_TARGET=arm-linux-gnueabihf
HERO_BUILD_TARGET=x86_64-linux-gnu
HERO_HOST_USE_NEWLIB=0
HERO_HOST_LINUX_ARCH=arm
HERO_HOST_GLIBC=glibc-2.21

RET=0

HERO_GCC_INSTALL_DIR=`realpath install`
if [ ! -d "${HERO_GCC_INSTALL_DIR}" ]; then
  mkdir -p ${HERO_GCC_INSTALL_DIR}
fi

HERO_GCC_BUILD_DIR=`realpath build`
if [ ! -d "${HERO_GCC_BUILD_DIR}" ]; then
  mkdir -p ${HERO_GCC_BUILD_DIR}
fi

HERO_HOST_SRC_DIR=`realpath src`
if [ ! -d "${HERO_HOST_SRC_DIR}" ]; then
  mkdir -p ${HERO_HOST_SRC_DIR}
fi

HERO_HOST_GCC_SRC_DIR=`realpath src/riscv-gcc`
if [ ! -d "${HERO_HOST_GCC_SRC_DIR}" ]; then
  mkdir -p ${HERO_HOST_GCC_SRC_DIR}
fi

HERO_HOST_GCC_BUILD_DIR=`realpath ${HERO_GCC_BUILD_DIR}/${HERO_HOST_TARGET}`
if [ ! -d "${HERO_HOST_GCC_BUILD_DIR}" ]; then
  mkdir -p ${HERO_HOST_GCC_BUILD_DIR}
fi

if [ -z "${HERO_LINUX_KERNEL_DIR}" ]; then
	echo "Error: HERO_LINUX_KERNEL_DIR environmental variables is missing!"
	RET=1
fi
HERO_HOST_LINUX_KERNEL_DIR=${HERO_LINUX_KERNEL_DIR}

export PATH="${HERO_GCC_INSTALL_DIR}/bin":${PATH}
export LD_LIBRARY_PATH="${HERO_GCC_INSTALL_DIR}/lib":${LD_LIBRARY_PATH}

if [ -z "${HERO_SDK_DIR}" ]; then
	echo "Error: HERO_SDK_DIR environmental variables is missing!"
	RET=1
fi
if [ -z "${PLATFORM}" ]; then
	echo "Error: PLATFORM environmental variables is missing!"
	RET=1
fi
if [ -z "${PULP_SDK_INSTALL}" ]; then
	echo "Error: PULP_SDK_INSTALL environmental variables is missing!"
	RET=1
fi

# export PULP_HERO_CPPFLAGS="-I${PULP_SDK_INSTALL}/include/archi/chips/bigpulp -I${PULP_SDK_INSTALL}/include -I${HERO_SDK_DIR}/libpulp-offload/inc -O3 -Wall -g2 -shared -fPIC -DPLATFORM=${PLATFORM}"
# export PULP_HERO_LDFLAGS="-L${HERO_SDK_DIR}/libpulp-offload/lib -lpulp-offload"

# GCC PULP HERO Libgomp plugin compilation flags
export LIBGOMP_PLUGIN_PULP_HERO_CPPFLAGS="-I${PULP_SDK_INSTALL}/include/archi/chips/bigpulp -I${PULP_SDK_INSTALL}/include -I${HERO_SDK_DIR}/libpulp-offload/inc -DPLATFORM=${PLATFORM}"
export LIBGOMP_PLUGIN_PULP_HERO_LDFLAGS="-L${HERO_SDK_DIR}/libpulp-offload/lib -lpulp-offload"

# MKOFFLOAD external compilation flags
export PULP_HERO_EXTCFLAGS="-march=rv32imcxpulpv2 -D__riscv__ -DPLATFORM=${PLATFORM} -Wextra -Wall -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -Wundef -fdata-sections -ffunction-sections -I${PULP_SDK_INSTALL}/include/io -I${PULP_SDK_INSTALL}/include"
export PULP_HERO_EXTLDFLAGS="${PULP_SDK_INSTALL}/lib/bigpulp-z-7045/crt0.o -nostartfiles -nostdlib -L${PULP_SDK_INSTALL}/lib/bigpulp-z-7045 -L${HERO_GCC_INSTALL_DIR}/lib -L${HERO_GCC_INSTALL_DIR}/lib/gcc/riscv32-unknown-elf/7.1.1/accel/riscv32-unknown-elf -lrt -lrtio -lrt -lgcc -lgomp -lbench"

return $RET

# That's all folks!!
