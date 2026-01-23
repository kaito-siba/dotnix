{ pkgs, noctalia, ... }:
{
  imports = [
    noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    gpu-screen-recorder
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
      bar = {
        density = "default";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "SystemMonitor";
            }
            {
              id = "ActiveWindow";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "MediaMini";
            }
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "plugin:screen-recorder";
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Catppuccin";
      # general = {
      #   avatarImage = "/home/drfoobar/.face";
      #   radiusRatio = 0.2;
      # };
      location = {
        monthBeforeDay = true;
        name = "Tokyo";
      };
      # systemd.enable = true;
    };
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };
    # this may also be a string or a path to a JSON file.
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "/home/rkv12/nixos/assets/wallpaper_3.jpg";
    };
  };
}
