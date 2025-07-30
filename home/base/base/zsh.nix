{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      ls = "exa --icons";
      lg = "lazygit";
    };
  };
}
