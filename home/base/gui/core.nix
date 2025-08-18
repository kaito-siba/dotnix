{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      dbeaver-bin
      google-chrome
    ]) ++
    (with pkgs-unstable; [
      slack
    ]);
}
