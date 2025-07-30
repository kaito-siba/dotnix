{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox-wayland
    libva
    libva-utils
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
  };

  systemd.user.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };
}
