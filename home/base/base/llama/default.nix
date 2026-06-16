{ pkgs, lib, pkgs-unstable, ... }:
{
  home.packages = [
    # CUDA対応でビルド(llama-server含む)。GPUオフロードで高速化。
    (pkgs-unstable.llama-cpp.override {
      cudaSupport = true;
    })
  ];

  xdg.configFile."llama" = {
    source = ./llama;
    recursive = true;
  };
}
