{ ... }:
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
    };
    extraConfig = ''
    monitor=DP-6,3840x2160@60,0x0,1.5
    monitor=HDMI-A-3,1920x1080@60,2560x360,1
    '';
  };
}
