{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
    };
    font = {
      name = "Noto Sans CJK JP";
    };
  };
}
