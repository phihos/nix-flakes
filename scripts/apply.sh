#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}/.."
alejandra . &>/dev/null
sudo nixos-rebuild switch --flake .
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd
SCRIPT_DIR/cleanup.sh
