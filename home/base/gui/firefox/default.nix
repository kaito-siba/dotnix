{ pkgs, ... }:let
  profile = "default";
in {
  home.packages = with pkgs; [
    libva
    libva-utils
  ];

  systemd.user.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  home.file = {
    ".config/tridactyl" = {
      source = ./tridactyl;
      recursive = true;
    };
  };
}
