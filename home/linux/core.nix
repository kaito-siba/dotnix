{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.dolphin
    quickshell
    cage # A Wayland kiosk (https://yalter.github.io/niri/Xwayland.html#using-the-cage-wayland-compositor)
  ];
}
