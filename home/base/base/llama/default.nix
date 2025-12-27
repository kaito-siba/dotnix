{ pkgs, lib, pkgs-unstable, ... }:
{
  home.packages = [
    pkgs-unstable.llama-cpp
  ];

  xdg.configFile."llama" = {
    source = ./llama;
    recursive = true;
  };
}
