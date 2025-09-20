{ pkgs, ghostty, ... }:
{
  home.packages = with pkgs; [
    ghostty.packages.${pkgs.system}.default
  ];

  xdg.configFile."ghostty/config".source = ./config;
}
