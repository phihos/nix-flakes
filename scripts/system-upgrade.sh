#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd "${SCRIPT_DIR}/.."
nix flake update
sudo nixos-rebuild switch --flake . --upgrade --commit-lock-file
git commit -am "system-upgrade"
popd
