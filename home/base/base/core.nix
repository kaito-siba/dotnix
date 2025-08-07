{ pkgs, ... }:
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
    fzf

    ghq # Remote repository management made easy

    neofetch

    wl-clipboard
    bat
  ];
}
