{ config, lib, ... }:
{
  # https://discourse.nixos.org/t/changing-gdm-gsettings-declaratively/49579/7
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3";
      color-scheme = "prefer-dark";
    };
  };
}
