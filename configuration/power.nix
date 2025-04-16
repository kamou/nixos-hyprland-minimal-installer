{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    brightnessctl
    upower
    power-profiles-daemon
  ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
