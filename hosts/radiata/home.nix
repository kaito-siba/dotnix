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

    systemd.user.targets.hyprland-session = {
      Unit = {
        Description = "Hyprland compositor session";
        Documentation = ["man:systemd.special(7)"];
        BindsTo = ["graphical-session.target"];
        Wants = ["graphical-session-pre.target"];
        After = ["graphical-session-pre.target"];
      };
    };

    wayland.windowManager.hyprland = {
      extraConfig = ''
        exec-once = fcitx5 -d
        exec-once = hyprlock || hyprctl dispatch exit

        exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user start hyprland-session.target

        exec-once = copyq --start-server

        monitor = DP-1, 3440x1440@120, 0x0, 1

        windowrulev2 = float,        class:^(com\.github\.hluk\.copyq)$
        windowrulev2 = center,       class:^(com\.github\.hluk\.copyq)$
        windowrulev2 = size 800 600, class:^(com\.github\.hluk\.copyq)$
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
