# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/), and this project adheres to
[Semantic Versioning](http://semver.org).

## v2.0.0 - 2018-12-4

### Added
- New repo structure:
	- Builder utilities and tools are now stored in a new folder `bin`.
	- `bin/*` utilities are installed to the `$PATH` using by the `setup.sh`.
	- `install` folder is moved to `pkg/hero-gcc-toolchain`.
	- `build` folder is moved to `pkg/build`.
- New `bin/hero_toolchain_artifact` tool for create/deploy/download artifacts.
- New `bin/hero_toolchain_build` tool for build the toolchain. It integrates in a single tool the removed `hero_riscv32_toolchain_builder` and `hero_arm_toolchain_builder`.
- New `bin/hero_toolchain_installer` tool for board installation of the toolchain.
- New `bin/hero_toolchain_update_sources` tool for fast update of submodules.

### Removed
- `hero_riscv32_toolchain_builder` integrated into `bin/hero_toolchain_build`.
- `hero_arm_toolchain_builder` integrated into `bin/hero_toolchain_build`.
- `scripts/hero_riscv32_toolchain_env.sh` integrated into `env/hero_toolchain_env.sh`.
- `scripts/hero_arm_toolchain_env.sh` integrated into `env/hero_toolchain_env.sh`.
- `scripts/install_toolchain.sh` integrated into `bin/hero_toolchain_installer`.
- `scripts/hero_toolchain_get_sources.sh` integrated into `env/hero_toolchain_update_sources`.

### Changed
- Update `src/riscv-gcc`, `src/binutils`, and `src/newlib` submodules.


## v1.1.1 - 2018-10-18

### Fixed
- `scripts/*`: environmental variables are now based on absolute addresses. `setup.sh` can be called from any location.


## v1.1.0 - 2018-10-17

### Added
- Enable shallow clone for the submodules when `HERO_CI` is set.

### Changed
- Update `riscv-gcc` and `binutils` modules from PULP mainstream compiler.

### Fixed
- Replace `realpath` with `readlink -f`.


## v1.0.0 - 2018-09-14

Initial Public Release of HERO GCC Toolchain
