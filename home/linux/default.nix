{ pkgs, ... }:
{
  imports = [
    ../base
    ./core.nix
    ./screenshot.nix
    ./core.nix

    ./wayland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpanel.nix
    ./clipboard.nix
    ./walker
    ./smoothcsv.nix
    ./obsidian.nix
    ./noctalia
  ];
}
