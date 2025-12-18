let wallpaperPath = "~/nixos/assets/wallpaper_2.jpg";
in {
  # Define the user module as a function to receive { pkgs, ... }
  w963n = { pkgs, ... }: {
    imports = [ ../../home/linux ];

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
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };

    wayland.windowManager.hyprland = {
      extraConfig = ''
        exec-once = fcitx5 -d
        exec-once = hyprlock || hyprctl dispatch exit

        exec-once = dbus-update-activation-environment --systemd --all
        exec-once = systemctl --user start hyprland-session.target

        monitor=DP-6,3840x2160@60,0x0,1.5
        monitor=HDMI-A-3,1920x1080@60,2560x360,1

        workspace = 1, monitor:DP-6, persistent:true, default:true
        workspace = 2, monitor:DP-6
        workspace = 3, monitor:DP-6
        workspace = 4, monitor:DP-6
        workspace = 5, monitor:DP-6
        workspace = 6, monitor:DP-6
        workspace = 7, monitor:DP-6
        workspace = 8, monitor:DP-6
        workspace = 9, monitor:DP-6
        workspace = 0, monitor:DP-6
        workspace = A, monitor:DP-6
        workspace = C, monitor:DP-6
        workspace = E, monitor:DP-6
        workspace = F, monitor:DP-6
        workspace = G, monitor:DP-6
        workspace = I, monitor:DP-6
        workspace = M, monitor:DP-6
        workspace = N, monitor:DP-6
        workspace = P, monitor:DP-6
        workspace = R, monitor:DP-6
        workspace = T, monitor:DP-6
        workspace = U, monitor:DP-6
        workspace = V, monitor:DP-6
        workspace = W, monitor:DP-6
        workspace = X, monitor:DP-6
        workspace = Y, monitor:DP-6
        workspace = Z, monitor:DP-6

        workspace = B, monitor:HDMI-A-3, persistent:true, default:true
        workspace = S, monitor:HDMI-A-3, persistent:true, default:false
        workspace = D, monitor:HDMI-A-3, persistent:true, default:false
        workspace = O, monitor:HDMI-A-3, persistent:true, default:false

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
