{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_24
  ];
  programs.yarn = {
      enable = true;
  };
}
