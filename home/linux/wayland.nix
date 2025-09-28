{ pkgs, lib, config, ... }:let
  mkElectronWayland = app: extraFlags: pkgs.symlinkJoin {
     name = "${app.name}-wayland";
     paths = [ app ];
     buildInputs = [ pkgs.makeWrapper ];
     postBuild = ''
      wrapProgram $out/bin/* \
        --add-flags "--enable-features=UseOzonePlatform ${extraFlags}"
     '';
  };
in {
  nixpkgs.overlays = [
   (final: prev: {
      lmstudio = mkElectronWayland prev.lmstudio
       "--enable-features=WaylandWindowDecorations --ozone-platform-hint=auto";
    })
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "ALT";
      bind = 
        [
          "$mod, B, exec, zen"
          "$mod, T, exec, ghostty"
          "$mod, S, exec, slack"
          # "SUPER, SPACE, exec, wofi --show drun"
          "SUPER, SPACE, exec, walker"
          "CTRL_SHIFT, code:11, exec, grim -g \"$(slurp)\" - | swappy -f -"
          "CTRL_SHIFT, code:12, exec, grim - | swappy -f -"
          "CTRL_SHIFT, code:13, exec, grim -g \"$(slurp)\" ${config.xdg.userDirs.pictures}/Screenshots/$(date +%Y-%m-%d-%H%M%S).png"
          # "CTRL_SHIFT, V, exec, ~/.local/bin/clipmenu-wofi"
          # "CTRL_SHIFT, V, exec, walker --mode clipboard"
        ]
        ++ (
         # workspaces
         # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
         builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );
      input = {
        repeat_delay = 300;
        repeat_rate = 30;
        follow_mouse = 1;
        sensitivity = lib.mkDefault (-0.5); # -1.0 - 1.0, 0 means no modification.
      };
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.inactive_border" = "0xff222436";
        "col.active_border" = "0xff82aaff";
        resize_on_border = true;
      };
      decoration = {
        rounding = 10;
        active_opacity = 0.9;
        inactive_opacity = 0.9;
        blur = {
          enabled = false;
          size = 6;
          passes = 1;
          xray = false;
          ignore_opacity = true;
          new_optimizations = true;
        };
      };
      animations = {
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier, slide"
          "border, 1, 5, default"
          "fade, 1, 5, default"
          "workspaces, 1, 6, default"
        ];
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 8;
  };

  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg.configFile."code-flags.conf".source = config.xdg.configFile."electron-flags.conf".source;
  xdg.configFile."spotify-flags.conf".source = config.xdg.configFile."electron-flags.conf".source;

  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.FileChooser=gtk
  '';

  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

}
