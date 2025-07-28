{config, pkgs, ... }:

{
  home.username = "w963n";
  home.homeDirectory = "/home/w963n";

  home.packages = with pkgs; [
    neofetch
    yazi # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf

    # productivity
    lazygit
  ];

  programs.git = {
    enable = true;
    userName = "k-nanchi";
    userEmail = "kaito@siba-service.jp";
  }; 

  programs.starship = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
  };

  home.stateVersion = "25.05";
}
