{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    walker
  ];

  xdg.configFile."walker/config.toml".source = ./config.toml;
}
