let
  wallpaperPath = "~/nixos/assets/wallpaper_2.jpg";
in {
  # Define the user module as a function to receive { pkgs, ... }
  w963n = { pkgs, ... }: {
    imports = [
      ../../home/linux
    ];

    home = {
      username = "w963n";
      homeDirectory = "/home/w963n";
      stateVersion = "25.05";
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

        exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user start hyprland-session.target
        exec-once = walker --gapplication-service

        monitor=DP-6,3840x2160@60,0x0,1.5
        monitor=HDMI-A-3,1920x1080@60,2560x360,1

        workspace = 1, monitor:DP-6
        workspace = 2, monitor:DP-6
        workspace = 3, monitor:HDMI-A-3
        workspace = 4, monitor:HDMI-A-3

        windowrulev2 = float,        class:^(com\.github\.hluk\.copyq)$
        windowrulev2 = center,       class:^(com\.github\.hluk\.copyq)$
        windowrulev2 = size 800 600, class:^(com\.github\.hluk\.copyq)$
      '';
    };

    services.hyprpaper = {
      settings = {
        preload = [ wallpaperPath ];
        wallpaper = [ "DP-6,${wallpaperPath}" "HDMI-A-3,${wallpaperPath}" ];
      };
    };
  };
}
