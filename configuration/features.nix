{ mode }:
let
  flags = {
    laptop = {
      wm = true;
      power = true;
    };
    desktop = {
      wm = true;
      power = false;
    };
    headless = {
      wm = false;
      power = false;
    };
  };
  cfg = flags.${mode} or {
    wm = false;
    power = false;
  };
in ((if cfg.wm then [ ./wm/hyprland.nix ./wm/kdeconnect.nix ] else [ ]))
++ (if cfg.power then [ ./power.nix ] else [ ])
