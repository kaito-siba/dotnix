{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = [
    (pkgs-unstable.llama-cpp.override {
      cudaSupport = true;
    })
  ];

  xdg.configFile."llama" = {
    source = ./llama;
    recursive = true;
  };
}
