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
    initContent = ''
      stty -ixon
      bindkey '^R' _atuin_search-widget
    '';
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;
      filter_mode = "directory";
      keymap_mode = "auto";
    };
  };
}
