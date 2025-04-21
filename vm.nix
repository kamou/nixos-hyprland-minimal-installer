{

  users.users.nixos = {
    isNormalUser = true;
    password = "nixos";
    extraGroups = [ "wheel" ];
  };
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
  services.qemuGuest.enable = true;
}
