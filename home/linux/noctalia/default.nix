{ pkgs, noctalia, ... }:
{
  imports = [
    noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    gpu-screen-recorder
    wtype
    gradia
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
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

  xdg.configFile."noctalia/settings.json".source = ./settings.json;
}
