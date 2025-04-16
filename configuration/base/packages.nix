{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    age
    btop
    clang
    cmake
    curl
    fd
    git
    gnumake
    jq
    killall
    neovim
    nerdfetch
    ripgrep
    rustup
    tree
    yq
  ];

  # Default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
