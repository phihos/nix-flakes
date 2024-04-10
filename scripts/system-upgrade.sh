#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}/.."
sudo nixos-rebuild switch --flake . --upgrade --upgrade-all
git commit -am "system-upgrade"
popd
