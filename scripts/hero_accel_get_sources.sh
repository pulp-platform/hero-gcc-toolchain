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

cd ${HERO_ACCEL_SRC_DIR}
git submodule update --init --recursive

cd ${HERO_ACCEL_GCC_SRC_DIR}
git submodule update --init --recursive
# Download GCC prerequisites
${HERO_ACCEL_GCC_SRC_DIR}/contrib/download_prerequisites	

# Binutils sources
cd ${HERO_ACCEL_SRC_DIR}/binutils
git submodule update --init --recursive

# Newlib sources
cd ${HERO_ACCEL_SRC_DIR}/newlib
git submodule update --init --recursive

# That's all folks!!
