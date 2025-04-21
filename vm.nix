{ headless, ... }: {

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

  virtualisation.vmVariant = {
    virtualisation.forwardPorts = [{
      from = "host";
      host.port = 2222;
      guest.port = 22;
    }];
    virtualisation.memorySize = 8096;
    virtualisation.diskSize = 16384;
    # 4 cpus
    virtualisation.cores = 2;
    # for headless mode
    virtualisation.graphics = !headless;
  };
}
