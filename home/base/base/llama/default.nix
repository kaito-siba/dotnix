{
  pkgs,
  lib,
  llama-cpp,
  ...
}:
{
  home.packages = [
    llama-cpp.packages.${pkgs.system}.cuda
  ];

  xdg.configFile."llama" = {
    source = ./llama;
    recursive = true;
  };
}
