#!/usr/bin/env bash
set -e

download_bridgr() {
  local install_type=$1
  local install_version=$2
  local download_path=$3

  case $(uname -s) in
    Darwin) os="MacOS" ;;
    Linux) os="Linux" ;;
    *) os="Windows" ;;
  esac

  case $(uname -m) in
    x86_64) arch="amd64" ;;
    arm64) arch-"arm64" ;;
    *) arch="other" ;;
  esac

  if [[ $arch == other ]]; then
    echo "Unsupported architecture $(uname -m). Only x64/arm64 binaries are available."
    exit 2
  fi
    
  if [[ $arch == arm64 ]] && [[ $os != Linux ]]; then
    echo "$(uname -m) is only supported for Linux builds."
    exit 2
  fi

  if [[ $install_type == "ref" ]]; then
    echo "Only released versions are supported"
    exit 3
  fi

  download="https://github.com/aztechian/bridgr/releases/download/v${install_version}/bridgr-${os}-${arch}"
  cksum="https://github.com/aztechian/bridgr/releases/download/v${install_version}/bridgr-${os}-${arch}.sha256"

  if [ ! -d "${download_path}/bin" ]; then
    mkdir -p "${download_path}/bin"
  fi

  curl -fL# -N "${download}" -o "${download_path}/bridgr"
  curl -sL "${cksum}" -o "${download_path}/bridgr.sha256"

  validate "${download_path}/bridgr" "${download_path}/bridgr.sha256"
}


validate() {
  local target=$1
  local checksum=$2

  if builtin type -P openssl &>/dev/null; then
    is=$(digest_openssl "${target}")
  else
    is=$(digest_sum "${target}")
  fi
  shouldbe=$(cat "${checksum}")

  # shellcheck disable=SC2053
  if [[ $is != $shouldbe ]]; then
    echo "Checksums don't match!"
    exit 2
  fi
}

digest_openssl() {
  local target=$1
  openssl dgst -sha256 -hex "${target}" | cut -d' ' -f2
}

digest_sum() {
  local target=$1
  if [[ $(uname -s) == Darwin ]]; then
    shasum -a 256 "${target}" | cut -d' ' -f2
  else
    sha256sum "${target}" | cut -d' ' -f2
  fi
}

