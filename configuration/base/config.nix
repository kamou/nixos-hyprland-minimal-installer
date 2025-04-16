{ pkgs, ... }: {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable flake support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
