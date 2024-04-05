#!/usr/bin/env bash
set -e

sudo nix-collect-garbage --delete-older-than '7d'
df -h | grep -v /run | grep -v /sys | grep -v '% /dev'
