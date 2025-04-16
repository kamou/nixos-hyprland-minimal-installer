{
  description =
    "Simple NixOS Flake for building a graphical installer ISO (Calamares)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix"
          ./installer/embed-flake.nix
        ];
      };
    };
}
