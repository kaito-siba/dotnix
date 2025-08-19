{ pkgs, ... }:
{
  imports = [
    ../base
    ./screenshot.nix

    ./wayland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpanel.nix
    ./clipboard.nix
    ./walker
  ];
}
