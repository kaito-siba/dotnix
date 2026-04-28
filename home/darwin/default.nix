{ ... }:
{
  imports = [
    ./aw-sync.nix
  ];

  home.username = "k-nanchi";
  home.homeDirectory = "/Users/k-nanchi";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
