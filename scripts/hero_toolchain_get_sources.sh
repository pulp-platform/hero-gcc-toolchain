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

source ${HERO_TOOLCHAIN_DIR}/scripts/hero_arm_toolchain_env.sh
source ${HERO_TOOLCHAIN_DIR}/scripts/hero_riscv32_toolchain_env.sh

get_submodules() {
    if [[ ! ${HERO_CI+x} ]]; then
        git submodule update --init
    else
        git submodule init
        for i in $(git submodule | sed -e 's/.* //'); do
        	git config -f .gitmodules submodule.$i.shallow true
            spath=$(git config -f .gitmodules --get submodule.$i.path)
            surl=$(git config -f .gitmodules --get submodule.$i.url)
            sbranch=$(git config -f .gitmodules --get submodule.$i.branch)
            sha1=$(git rev-parse @:$spath)
            if [ -n "$(find "$spath" -maxdepth 0 -type d -empty 2>/dev/null)" ]; then
                git clone --depth 1 $surl $spath -b $sbranch
            fi
        done
        git submodule update
    fi
}

get_sources() {
	# Get submodules
	get_submodules

	# Get GCC prerequisites
    cd ${HERO_ACCEL_GCC_SRC_DIR}
    ${HERO_ACCEL_GCC_SRC_DIR}/contrib/download_prerequisites
    

    # Get Glibc for HOST
    cd ${HERO_HOST_SRC_DIR} 
    rm -rf $HERO_HOST_GLIBC
    rm -rf $HERO_HOST_GLIBC.tar.xz
    {
        wget --tries=1 --timeout=60 -nc http://mirror.switch.ch/ftp/mirror/gnu/glibc/$HERO_HOST_GLIBC.tar.xz
    } || {
        wget -nc https://ftp.gnu.org/gnu/glibc/$HERO_HOST_GLIBC.tar.xz
    }
    for f in *.tar*; do tar xfk $f; done
    rm -rf $HERO_HOST_GLIBC.tar.xz
}

get_sources
if [ $? -ne 0 ]; then
	echo "ERROR: failed to get sources."
    exit 1
fi
