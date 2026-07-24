{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    with pkgs;
    [
      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      jq
      yq-go
      eza
      visidata
      ffmpeg

      ghq # Remote repository management made easy

      fastfetch

      bat
      uv
      lazysql

      # aws
      awscli2
      ssm-session-manager-plugin
      stu

      postgresql
      mysql-shell

      fd
      with-shell
      lnav
      zeal
      mysql84

      matugen

      python314
      glib
      nvtopPackages.full

      intelephense
    ]
    ++ (with pkgs-unstable; [
      devenv
      keifu
    ]);

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.mpv = {
    enable = true;
  };
}
