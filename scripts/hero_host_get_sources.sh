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
# This script downloads sources from the repositories

# Setup the envioronmental variables
source scripts/hero_host_env.sh

cd ${HERO_HOST_SRC_DIR}
git submodule update --init --recursive

cd ${HERO_HOST_GCC_SRC_DIR}
git submodule update --init --recursive

# Binutils sources
cd ${HERO_HOST_SRC_DIR}/binutils
git submodule update --init --recursive

if [ $HERO_HOST_USE_NEWLIB -ne 0 ]; then
	# Newlib sources
	cd ${HERO_HOST_SRC_DIR}/newlib
	git submodule update --init --recursive
else
	# Get Kernel Sources
	# wget -nc https://www.kernel.org/pub/linux/kernel/v3.x/$LINUX_KERNEL_VERSION.tar.xz
	
	# Get Glibc
	cd ${HERO_HOST_SRC_DIR}	
	rm -rf $HERO_HOST_GLIBC
	rm -rf $HERO_HOST_GLIBC.tar.xz
	wget -nc https://ftp.gnu.org/gnu/glibc/$HERO_HOST_GLIBC.tar.xz
	for f in *.tar*; do tar xfk $f; done
	rm -rf $HERO_HOST_GLIBC.tar.xz
fi

# That's all folks!!
