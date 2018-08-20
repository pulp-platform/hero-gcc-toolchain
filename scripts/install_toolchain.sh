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

source scripts/hero_arm_toolchain_env.sh
source scripts/hero_riscv32_toolchain_env.sh

RET=0
if [ -z "${HERO_TARGET_HOST}" ]; then
    echo "Error: HERO_TARGET_HOST environmental variables is missing!"
    RET=1
fi
if [ -z "${HERO_TARGET_PATH}" ]; then
    echo "Error: HERO_TARGET_PATH environmental variables is missing!"
    RET=1
fi
if [ -z "${HERO_GCC_INSTALL_DIR}" ]; then
    echo "Error: HERO_GCC_INSTALL_DIR environmental variables is missing!"
    RET=1
fi
if [ "${RET}" -eq "0" ]; then
    rsync -rctacvP ${HERO_GCC_INSTALL_DIR}/arm-linux-gnueabihf/lib/libgomp* ${HERO_TARGET_HOST}:${HERO_TARGET_PATH_LIB}/.
fi

exit $RET
