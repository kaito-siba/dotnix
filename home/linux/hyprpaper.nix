{ config, pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
        ipc = "off";
        splash = "off";
      };
  };
}
