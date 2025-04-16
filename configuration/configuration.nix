let
  profile = import ./profile.nix;
  baseImports = [ ./base/config.nix ./base/packages.nix ./network.nix ];
  featureImports = import ./features.nix { mode = profile.mode; };
  originalImport = if profile.vm then [ ] else [ ./original/configuration.nix ];
  vmImports = if profile.vm then [ ./vm.nix ] else [ ];
in { imports = originalImport ++ baseImports ++ featureImports ++ vmImports; }
