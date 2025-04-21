{
  description =
    "Simple NixOS Flake for building a graphical installer ISO (Calamares)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs, ... }:
    let system = "x86_64-linux";
    in {
      isoImage = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix"
          ./installer/embed-flake.nix
        ];
      };

      vmImage = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration/configuration.nix
          (import ./vm.nix { headless = false; })
        ];
      };

      headlessVmImage = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration/configuration.nix
          (import ./vm.nix { headless = true; })
        ];
      };

      packages.${system} = {
        iso = self.isoImage.config.system.build.isoImage;
        vm = self.vmImage.config.system.build.vm;
        hvm = self.headlessVmImage.config.system.build.vm;
      };
    };
}
