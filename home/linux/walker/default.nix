{ pkgs, config, walker, ... }:
{
  imports = [
    walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;

    theme.style = ''
      * {
        @window_bg_color: #dcd7ba;
        @accent_bg_color: #dcd7ba;
        @theme_fg_color: #dcd7ba;
      }
    '';
  };

}
