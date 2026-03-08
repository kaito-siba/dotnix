{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      dbeaver-bin
      zeal
      geary
    ])
    ++ (with pkgs-unstable; [
      slack
      discord
      obsidian
      google-chrome
    ]);
}
