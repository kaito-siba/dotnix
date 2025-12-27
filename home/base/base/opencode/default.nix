{ pkgs, opencode, ... }:
{
  home.packages = [
    opencode.packages.${pkgs.system}.default 
  ];

  xdg.configFile."opencode/opencode.json".source = ./opencode.json;
}
