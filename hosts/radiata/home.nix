let
  wallpaperPath = "~/nixos/assets/wallpaper_3.jpg";
in {
  # Define the user module as a function to receive { pkgs, ... }
  rkv12 = { pkgs, ... }: {
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

        exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user start hyprland-session.target

        monitor = DP-1, 3440x1440@120, 0x0, 1
      '';
    };

    services.hyprpaper = {
      settings = {
        preload = [ wallpaperPath ];
        wallpaper = [ "DP-1,${wallpaperPath}" ];
      };
    };
  };
}
