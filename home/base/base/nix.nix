{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    devbox
  ];
}
