#!/bin/bash
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
# Installation script for HERO GCC 7.1.1 toolchain


# Setup the envioronmental variables
if [[ ! ${HERO_TOOLCHAIN_DIR+x} ]]; then
	if [[ ! -f "${0##*/}" ]]; then
		echo  >&2 "Error: ${0##*/} should be launched from the directory that contains it"
	    exit 1
	fi
	export HERO_TOOLCHAIN_DIR=`readlink -f .`
fi

source ${HERO_TOOLCHAIN_DIR}/env/hero_toolchain_env.sh

export HERO_TOOLCHAIN_INSTALL_DIR=$HERO_TOOLCHAIN_INSTALL_DIR
export PATH=${HERO_TOOLCHAIN_DIR}/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH

# That's all folks!!
