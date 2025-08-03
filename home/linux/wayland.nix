{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "ALT";
      bind = 
        [
          "$mod, B, exec, firefox"
          "$mod, T, exec, kitty"
	  "SUPER, SPACE, exec, wofi --show drun"
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
        active_opacity = 0.8;
        inactive_opacity = 0.8;
        blur = {
          enabled = true;
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
}
