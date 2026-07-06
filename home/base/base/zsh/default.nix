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

      # tmuxのセッション環境からWAYLAND_DISPLAYを再取得し、既存ペインでも
      # 常に有効な値になるようにする（サーバーがブート時起動で古い値を持つ対策）
      if [[ -n "$TMUX" ]]; then
        _tmux_refresh_wayland() {
          local line
          line=$(tmux show-environment WAYLAND_DISPLAY 2>/dev/null)
          if [[ "$line" == WAYLAND_DISPLAY=* ]]; then
            export WAYLAND_DISPLAY="''${line#WAYLAND_DISPLAY=}"
          fi
        }
        autoload -Uz add-zsh-hook
        add-zsh-hook precmd _tmux_refresh_wayland
      fi
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
