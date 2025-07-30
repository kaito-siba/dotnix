{
  w963n = {
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

    wayland.windowManager.hyprland = {
      extraConfig = ''
      monitor=DP-6,3840x2160@60,0x0,1.5
      monitor=HDMI-A-3,1920x1080@60,2560x360,1
      '';
    };
  };
}
