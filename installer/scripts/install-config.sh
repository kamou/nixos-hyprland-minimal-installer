set -eux

ROOT=$(find /tmp -maxdepth 1 -type d -name 'calamares-root-*' | head -n1)

mkdir -p ${ROOT}/etc/nixos/original
mv ${ROOT}/etc/nixos/configuration.nix ${ROOT}/etc/nixos/original/configuration.nix
mv ${ROOT}/etc/nixos/hardware-configuration.nix ${ROOT}/etc/nixos/original/hardware-configuration.nix

cp -r /iso/configuration-src/configuration/. ${ROOT}/etc/nixos/
