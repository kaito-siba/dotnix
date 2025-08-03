{ pkgs, ... }:
{
  imports = [
    ../base

    ./wayland.nix
    ./hyprlock.nix
  ];
}
