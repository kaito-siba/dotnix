{ pkgs, ... }:
{
  imports = [
    ../base

    ./wayland.nix
  ];
}
