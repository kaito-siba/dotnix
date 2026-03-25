{ ... }:
{
  programs.wezterm = {
    enable = true;
    # package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
}
