{ config, lib, ... }:

let
  profile = import ./profile.nix;
  baseImports = [ ./base/config.nix ./base/packages.nix ./network.nix ];
  featureImports = import ./features.nix { mode = profile.mode; };
  originalImports = [ ./original/configuration.nix ];
in {

  imports = originalImports ++ baseImports ++ featureImports;
}
