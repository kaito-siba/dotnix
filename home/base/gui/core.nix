{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      dbeaver-bin
    ]) ++
    (with pkgs-unstable; [
      slack
    ]);
}
