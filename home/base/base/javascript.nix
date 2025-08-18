{ pkgs, ... }:
{
  home.packages = with pkgs; [
    biome
  ];
}
