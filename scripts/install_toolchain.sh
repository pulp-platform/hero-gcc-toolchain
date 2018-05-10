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

source scripts/hero_accel_env.sh
source scripts/hero_host_env.sh

RET=0
if [ -z "${PULP_EMU_ADDR}" ]; then
	echo "Error: PULP_EMU_ADDR environmental variables is missing!"
	RET=1
fi
if [ -z "${PULP_EMU_SHARE_DIR}" ]; then
	echo "Error: PULP_EMU_SHARE_DIR environmental variables is missing!"
	RET=1
fi
if [ -z "${HERO_GCC_INSTALL_DIR}" ]; then
	echo "Error: HERO_GCC_INSTALL_DIR environmental variables is missing!"
	RET=1
fi
if [ "${RET}" -eq "0" ]; then
	rsync -rctacvzP ${HERO_GCC_INSTALL_DIR}/* ${PULP_EMU_ADDR}:${PULP_EMU_SHARE_DIR}
fi

return $RET
