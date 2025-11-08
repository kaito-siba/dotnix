{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
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

    ghq # Remote repository management made easy

    neofetch

    bat
    python3Full
    uv
    lazysql

    # aws
    awscli2
    ssm-session-manager-plugin

    mariadb
  ] ++ (with pkgs-unstable; [
    devenv
  ]);

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
