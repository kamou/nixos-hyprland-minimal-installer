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

or, for a headless alternative:

```bash
nix build .#hvm
```

The generated `run-nixos-vm` script to run the VM is stored in `result/bin/`
VM settings (such as memory size, cpu count etc...) can be tweaked in `vm.nix`
