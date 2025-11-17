{ pkgs, walker, lib, ... }:
{
  imports = [
    walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
    config = lib.importTOML ./config.toml;
  };
}
