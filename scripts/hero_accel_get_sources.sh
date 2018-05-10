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
source scripts/hero_accel_env.sh

# Create sources folder
if [ ! -d "${HERO_ACCEL_SRC_DIR}" ]; then
  mkdir -p ${HERO_ACCEL_SRC_DIR}
fi

# Get GCC sources
if [ ! -d "${HERO_ACCEL_GCC_SRC_DIR}" ]; then
  mkdir -p ${HERO_ACCEL_GCC_SRC_DIR}
fi
cd ${HERO_ACCEL_GCC_SRC_DIR}
if [ ! -d ${HERO_ACCEL_GCC_SRC_DIR}/.git ]; then
	git init .
	git remote add origin git@github.com:pulp-platform/pulp-riscv-gcc.git
	git fetch --all

	# Get Sources
	git checkout hero-dev
	
	# Download GCC prerequisites
	${HERO_ACCEL_GCC_SRC_DIR}/contrib/download_prerequisites	
fi
# Update software
git checkout hero-dev

# Binutils sources
mkdir -p ${HERO_ACCEL_SRC_DIR}/binutils
cd ${HERO_ACCEL_SRC_DIR}/binutils
if [ ! -d ${HERO_ACCEL_SRC_DIR}/binutils/.git ]; then
	git init .
	git remote add origin git@github.com:pulp-platform/pulp-riscv-binutils-gdb.git
	git fetch --all
fi
git checkout 441e420

# Newlib sources
mkdir -p ${HERO_ACCEL_SRC_DIR}/newlib
cd ${HERO_ACCEL_SRC_DIR}/newlib
if [ ! -d ${HERO_ACCEL_SRC_DIR}/newlib/.git ]; then
	git init .
	git remote add origin git@github.com:pulp-platform/pulp-riscv-newlib.git
	git fetch --all
fi
git checkout 1e52935

# That's all folks!!
