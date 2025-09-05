{ pkgs, ... }:
{
  imports = [
    ../base
    ./core.nix
    ./screenshot.nix

    ./wayland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpanel.nix
    ./clipboard.nix
    ./walker
  ];
}
