### Hyprland NixOS Image Builder

This repository allows for building custom hyprland NixOS system images. (iso and VM)

### Using `profile.nix` to Configure the Environment

`configuration/profile.nix` is meant to setup the environment.

```nix
{
  mode = "laptop";
  vm = true;
}
```

- `mode` determines feature flags (handled in `features.nix`): possible values may be `laptop`, `desktop`, `headless`, etc.
- `vm` (bool) enables or disables VM-specific settings.

---

### ISO Generation

To build a graphical calamares based installer, run:

```bash
nix build .#nixosConfigurations.installer.config.system.build.isoImage
```

- The resulting ISO can be found under `result/iso/`.
- The ISO uses the config in the configuration folder and bundles Calamares for graphical installation.
- The clamaraes generated configuration.nix and hardware-configuration.nix will be stored in /etc/nixos/original

---

### VM Generation

To generate a QEMU virtual machine from your config, first edit configuraion/profile.nix to set the `vm` option to `true`.

Then, run the following command:

```bash
nixos-rebuild build-vm -I nixos-config=./configuration.nix
```

- After building, you’ll see an output such as:

```
Done.  The virtual machine can be started by running /nix/store/<hash>-nixos-vm/bin/run-nixos-vm
```

**Default Disk Size:**  
By default, the generated `run-nixos-vm` script allocates a disk image with size `1024M` (1 GiB). For most use cases, this is too small!

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
