{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-mirror
  ];
}
