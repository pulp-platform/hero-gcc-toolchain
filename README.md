# PULP HERO TOOLCHAIN

## Features
The PULP HERO Toolchain is a complete cross compiler equipped with offloading support over OpenMP4.5 on PULP HERO platform. The toolchain is provided within the PULP HERO SDK.

## Compilation Instruction

### 1. Clone the repo
The toolchain is delivered using GIT submodule. To automatically checkout the whole sources execute the following command:
```
git clone --recursive git@github.com:pulp-platform/pulp-hero-gnu-gcc-toolchain.git
```
or if you use HTTPS
```
git clone --recursive https://github.com/pulp-platform/pulp-hero-gnu-gcc-toolchain.git
```
### 2. Dependencies
> TL;TR;
> You should provide the following environmental variables:
> ```
> export PLATFORM="2"
> export HERO_SDK_DIR=`realpath ../`
> export HERO_LINUX_KERNEL_DIR=`realpath ../linux/zynqlinux/linux-xlnx`
> source ../pulp-sdk/sourceme.sh
> export HERO_TARGET_HOST=alessandro@zc706.eees
> export HERO_TARGET_PATH=/hsa/pulp-hero-gnu-gcc-toolchain
> ```

Before to compile the toolchain you should satisly the following dependencies:
* Provide the path to the HERO SDK root folder setting the environmental variable `HERO_SDK_DIR`. I.E.:
```
export HERO_SDK_DIR=`realpath ../
```
* Provide the path to the Linux Kernel sources used to build you host subsystem setting the environmental variable `HERO_LINUX_KERNEL_DIR`. I.e.:
```
export HERO_LINUX_KERNEL_DIR=`realpath ../linux/zynqlinux/linux-xlnx`
```
* Install and configure the [PULP SDK](https://github.com/pulp-platform/pulp-sdk). I.E. if you already build it:
```
source ../pulp-sdk/sourceme.sh
```
> PULP SDK Build procedure for HERO:
> ```
> git clone --recursive git@github.com:pulp-platform/pulp-sdk.git
> cd pulp-sdk
> source configs/hero-z-7045.sh
> make deps all env
> ```
> Then you will find the file `sourceme.sh` inside the folder `pulp-sdk`.

* Set the HERO Platform instance. I.E:
```
export PLATFORM="2"
```
* (optional) Finally setup the proper installation path. I.E.:
```
export HERO_TARGET_HOST=alessandro@zc706.eees
export HERO_TARGET_PATH=/hsa/pulp-hero-gnu-gcc-toolchain
```

* Source the setup script:
```
source setup.sh
```

### 3. Build the accelerator compiler
You can automaticically compile the accelerator toolchain using the following command:
```
./hero_accel_builder -z
```

### 4. Build the host compiler
You can automaticically compile the accelerator toolchain using the following command:
```
./hero_host_builder -z
```
### 5. Install the compiler
You can automaticically compile the accelerator toolchain using the following command:
```
scripts/install_toolchain
```

# Reseach References
TODO
