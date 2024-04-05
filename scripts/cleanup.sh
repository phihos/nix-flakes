#!/usr/bin/env bash
set -e

sudo nix-collect-garbage --delete-older-than '7d'
echo ""
echo "Remaining generations:"
nix-env --list-generations
echo ""
df -h | grep -v /run | grep -v /sys | grep -v '% /dev'
