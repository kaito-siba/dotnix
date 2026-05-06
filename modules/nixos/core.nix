{ pkgs, ... }:
{
  # https://github.com/tomrijndorp/vscode-finditfaster/issues/44
  services.envfs.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 14d --keep 5";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib # glibc, libstdc++ など
    zlib
    openssl
  ];

  boot.extraModprobeConfig = ''
    options nvidia-drm modeset=1 fbdev=0
  '';

  services.gvfs.enable = true;
}
