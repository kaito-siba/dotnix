{ pkgs, ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = [
    "ja_JP.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ 
      fcitx5-gtk
      fcitx5-mozc
    ];
    fcitx5.waylandFrontend = true;

    fcitx5.settings.inputMethod = {
      GroupOrder."0" = "Default";      
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "us";
        DefaultIM = "mozc";
      };
      "Groups/0/Items/0".Name = "mozc";
    };
  };
}
