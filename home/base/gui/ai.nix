{ pkgs, lib, ... }:
let
  lmstudio = pkgs.appimageTools.wrapType2 rec {
    pname = "lm-studio";
    version = "0.3.22-2";
    src = pkgs.fetchurl {
      # 公式 Beta Releases の Linux AppImage（x86_64）
      url = "https://installers.lmstudio.ai/linux/x64/${version}/LM-Studio-${version}-x64.AppImage";
      sha256 = "sha256-2zV9rsghdhaZCL+idzkv4oGT2SvPV04R0cHKoH137CY=";
    };
  };
in
{
  home.packages = [
    lmstudio
  ];
}
