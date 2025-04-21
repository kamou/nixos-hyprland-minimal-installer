set -eux

ROOT=$(find /tmp -maxdepth 1 -type d -name 'calamares-root-*' | head -n1)

mkdir -p ${ROOT}/etc/nixos/_original
mv ${ROOT}/etc/nixos/configuration.nix ${ROOT}/etc/nixos/_original/configuration.nix
mv ${ROOT}/etc/nixos/hardware-configuration.nix ${ROOT}/etc/nixos/_original/hardware-configuration.nix

cp -r /iso/configuration-src/configuration/. ${ROOT}/etc/nixos/

# remove fake configuration
rm -rf ${ROOT}/etc/nixos/original
mv ${ROOT}/etc/nixos/_original/ ${ROOT}/etc/nixos/original/
