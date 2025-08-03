{
  rkv12 = {
    imports = [
     ../../home/linux
    ];

    home = {
      username = "rkv12";
      homeDirectory = "/home/rkv12";
      stateVersion = "24.11";
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Electron apps to use Wayland
      };
    };

    wayland.windowManager.hyprland = {
      extraConfig = ''
      exec-once = fcitx5 -d
      exec-once = hyprlock || hyprctl dispatch exit
      monitor = DP-1, 3440x1440@120, 0x0, 1
      '';
    };
  };
}
