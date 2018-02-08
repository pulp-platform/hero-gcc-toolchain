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

# Create sources folder
if [ ! -d "${HERO_HOST_SRC_DIR}" ]; then
  mkdir -p ${HERO_HOST_SRC_DIR}
fi

# Get GCC sources
if [ ! -d "${HERO_HOST_GCC_SRC_DIR}" ]; then
  mkdir -p ${HERO_HOST_GCC_SRC_DIR}
fi
mkdir -p ${HERO_HOST_GCC_SRC_DIR}
cd ${HERO_HOST_GCC_SRC_DIR}
if [ ! -d ${HERO_HOST_GCC_SRC_DIR}/.git ]; then
	git init .
	git remote add origin git@github.com:alessandrocapotondi/pulp-riscv-gcc.git
	git fetch --all

	# Get Sources
	git checkout master
	
	
	# Download GCC prerequisites
	${HERO_HOST_GCC_SRC_DIR}/contrib/download_prerequisites	
else
	# Only update software
	git checkout master
fi

# Binutils sources
mkdir -p ${HERO_HOST_SRC_DIR}/binutils
cd ${HERO_HOST_SRC_DIR}/binutils
if [ ! -d ${HERO_HOST_SRC_DIR}/binutils/.git ]; then
	git init .
	git remote add origin git@github.com:pulp-platform/pulp-riscv-binutils-gdb.git
	git fetch --all
fi
git checkout 441e420

if [ $HERO_HOST_USE_NEWLIB -ne 0 ]; then
	# Newlib sources
	mkdir -p ${HERO_HOST_SRC_DIR}/newlib
	cd ${HERO_HOST_SRC_DIR}/newlib
	if [ ! -d ${HERO_HOST_SRC_DIR}/newlib/.git ]; then
		git init .
		git remote add origin git@github.com:pulp-platform/pulp-riscv-newlib.git
		git fetch --all
	fi
	git checkout 1e52935
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
