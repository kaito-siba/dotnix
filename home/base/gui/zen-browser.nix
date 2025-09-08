{ pkgs, zen-browser, ... }:
{
  imports = [ 
    zen-browser.homeModules.twilight
  ];

  # home.packages = [
  #   zenBrowser.packages.${pkgs.system}.twilight
  # ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.tridactyl-native ];
  };
}
