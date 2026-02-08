{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      dbeaver-bin
      google-chrome
      zeal
      geary
    ])
    ++ (with pkgs-unstable; [
      slack
      discord
      obsidian
    ]);
}
