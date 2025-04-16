{mode}: let
  flags = {
    laptop = {
      hypr = true;
      power = true;
    };
    desktop = {
      hypr = true;
      power = false;
    };
    headless = {
      hypr = false;
      power = false;
    };
  };
  cfg =
    flags.${mode}
    or {
      hypr = false;
      power = false;
    };
in
  (
    if cfg.hypr
    then [./shared/hyprland.nix]
    else []
  )
  ++ (
    if cfg.power
    then [./shared/power.nix]
    else []
  )
