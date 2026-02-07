{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nautilus
    quickshell
    adw-gtk3
    qt6Packages.qt6ct
    libsForQt5.qt5ct
  ];
}
