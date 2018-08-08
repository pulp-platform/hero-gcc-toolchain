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
# This environmental variables for the GCC 7.1.1 toolchain for the HERO accelerator

HERO_ACCEL_TARGET=riscv32-unknown-elf
HERO_BUILD_TARGET=x86_64-linux-gnu

HERO_GCC_INSTALL_DIR=`realpath install`
if [ ! -d "${HERO_GCC_INSTALL_DIR}" ]; then
  mkdir -p ${HERO_GCC_INSTALL_DIR}
fi

HERO_GCC_BUILD_DIR=`realpath build`
if [ ! -d "${HERO_GCC_BUILD_DIR}" ]; then
  mkdir -p ${HERO_GCC_BUILD_DIR}
fi

HERO_ACCEL_SRC_DIR=`realpath src`
if [ ! -d "${HERO_ACCEL_SRC_DIR}" ]; then
  mkdir -p ${HERO_ACCEL_SRC_DIR}
fi

HERO_ACCEL_GCC_SRC_DIR=`realpath src/riscv-gcc`
if [ ! -d "${HERO_ACCEL_GCC_SRC_DIR}" ]; then
  mkdir -p ${HERO_ACCEL_GCC_SRC_DIR}
fi

HERO_ACCEL_GCC_BUILD_DIR=`realpath ${HERO_GCC_BUILD_DIR}/${HERO_ACCEL_TARGET}`
if [ ! -d "${HERO_ACCEL_GCC_BUILD_DIR}" ]; then
  mkdir -p ${HERO_ACCEL_GCC_BUILD_DIR}
fi

export PATH="${HERO_GCC_INSTALL_DIR}/bin":${PATH}
export LD_LIBRARY_PATH="${HERO_GCC_INSTALL_DIR}/lib":${LD_LIBRARY_PATH}
export PATH="${HERO_ACCEL_GCC_INSTALL_DIR}/bin":${PATH}
export LD_LIBRARY_PATH="${HERO_ACCEL_GCC_INSTALL_DIR}/lib":${LD_LIBRARY_PATH}

# That's all folks!!
