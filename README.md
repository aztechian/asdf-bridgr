# asdf-bridgr

[![Build Status](https://travis-ci.com/aztechian/asdf-bridgr.svg?branch=master)](https://travis-ci.com/aztechian/asdf-bridgr)

[asdf-vm](https://github.com/asdf-vm/asdf) plugin to install [bridgr](https://github.com/aztechian/bridgr)

## Install

```shell
asdf plugin-add bridgr https://github.com/aztechian/asdf-bridgr.git
```

## Requirements

Asdf-bridgr uses some applications that are already installed on most Mac OS and Linux systems.

`curl` is uesd to fetch pre-built binaries of bridgr

`openssl` is used to validate SHA-256 checksums of the pre-built bridgr binaries

These applications are expected to be available. If you run into issues using asdf-bridgr, ensure that you have `curl` and `opnessl` available on your system.

## Usage

See the [asdf documentation](https://asdf-vm.com/#/core-manage-versions) for install and management of bridgr using asdf.

