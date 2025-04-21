### Hyprland NixOS Image Builder

This repository allows for building custom hyprland NixOS system images. (ISO installer and VM)

### Using `profile.nix` to Configure the Environment

`configuration/profile.nix` is meant to setup the environment.

```nix
{
  mode = "laptop";
}
```

- `mode` determines feature flags (handled in `features.nix`): possible values may be `laptop`, `desktop`, `headless`.

---

### ISO Generation

To build a graphical calamares based installer, run:

```bash
nix build .#iso
```

- The resulting ISO can be found under `result/iso/`.
- The ISO uses the config in the configuration folder and bundles Calamares for graphical installation.
- The clamaraes generated configuration.nix and hardware-configuration.nix will be stored in /etc/nixos/original

---

### VM Generation

To generate a QEMU virtual machine from your config, run the following command:

```bash
nix build .#vm
```

By default, the generated `run-nixos-vm` script (in result/bin/) allocates a disk image with size `1024M`. For most use cases, this is too small.

#### To Use a Larger VM Disk

1. Copy the generated `run-nixos-vm` script somewhere editable.
2. Edit the following line:

   ```bash
   createEmptyFilesystemImage "$NIX_DISK_IMAGE" "1024M"
   ```

   Change to, e.g.:

   ```bash
   createEmptyFilesystemImage "$NIX_DISK_IMAGE" "16G"
   ```

   This allocates a 16 GiB disk image.

3. Run your edited script to launch the VM.
