{ pkgs, ... }: {
  isoImage.contents = [{
    source = builtins.path {
      path = ./..;
      name = "configuration-src";
    };
    target = "/configuration-src";
  }];

  nixpkgs.overlays = [
    (final: prev: {
      calamares-nixos-extensions = prev.calamares-nixos-extensions.overrideAttrs
        (old: {
          postInstall = ''
            ${old.postInstall or ""}
            echo "Patching Calamares configs..."
            cp ${./conf/settings.conf} $out/share/calamares/settings.conf
            cp ${
              ./conf/install_configuration.conf
            } $out/share/calamares/modules/install_configuration.conf
            cp ${
              ./conf/rebuild_configuration.conf
            } $out/share/calamares/modules/rebuild_configuration.conf
            cp ${
              ./conf/packagechooser.conf
            } $out/share/calamares/modules/packagechooser.conf
          '';
        });
    })
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
