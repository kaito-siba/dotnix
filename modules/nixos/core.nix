{ pkgs, ... }:
{
  # https://github.com/tomrijndorp/vscode-finditfaster/issues/44
  services.envfs.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib  # glibc, libstdc++ など
    zlib openssl
  ];

  boot.extraModprobeConfig = ''
    options nvidia-drm modeset=1 fbdev=0
  '';
}
