{
  users.users.nixos = {
    isNormalUser = true;
    password = "nixos";
    extraGroups = [ "wheel" ];
  };
  services.displayManager.sddm = {
    autoLogin.enable = true;
    autoLogin.user = "nixos";
  };
  services.qemuGuest.enable = true;
}
