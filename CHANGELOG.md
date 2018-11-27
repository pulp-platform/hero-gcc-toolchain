# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/), and this project adheres to
[Semantic Versioning](http://semver.org).

## v1.2.0 - 2018-11-27

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
