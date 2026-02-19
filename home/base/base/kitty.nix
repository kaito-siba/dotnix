{ ... }:
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    font = {
      name = "Maple Mono NF CN";
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      window_margin_width = 10;
    };
    extraConfig = ''
      include ./themes/noctalia.conf
    '';
  };
}
