{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    sheldon
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "exa --icons -lag";
      lg = "lazygit";
    };
    setOptions = [
      "AUTO_LIST"
      "AUTO_MENU"
    ];
    initContent = ''
      stty -ixon
      bindkey '^R' _atuin_search-widget
      bindkey -r '^T'
      bindkey '^F' fzf-file-widget
      zstyle ':completion:*default' menu select=1 interactive
      eval "$(sheldon source)"
    '';
  };

  # history manager
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;
      filter_mode = "directory";
      keymap_mode = "auto";
    };
  };

  # fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables.GHQ_ROOT = "${config.home.homeDirectory}/ghq";

  # custom plugins
  xdg.configFile."sheldon/plugins.toml".source = ./plugins.toml;
  xdg.configFile."zsh/plugins/zsh-ghq-fzf/zsh-ghq-fzf.plugin.zsh".source = ./zsh-ghq-fzf.plugin.zsh;
  xdg.configFile."zsh/plugins/zsh-git-worktree-fzf/zsh-git-worktree-fzf.plugin.zsh".source =
    ./zsh-git-worktree-fzf.plugin.zsh;
}
