{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-q";
    mouse = true;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins;
      [
        sensible
        yank
        pain-control
        open
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-boot-options 'alacritty,fullscreen'
            set -g @continuum-save-interval '5' # save every 5 minutes
          '';
        }
        {
          plugin = catppuccin;
          extraConfig = ''

            set -g @catppuccin_flavour 'macchiato' # or latte, frappe, macchiato, mocha
            set -g @catppuccin_window_right_separator ""
            # set -g @catppuccin_window_right_separator "█"
            set -g @catppuccin_window_left_separator ""
            # set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_number_position "left"
            set -g @catppuccin_window_middle_separator " "
            set -g @catppuccin_window_default_text "#W"
            set -g @catppuccin_window_default_fill "none"
            set -g @catppuccin_window_current_fill "all"
            set -g @catppuccin_window_current_text "#W"
            set -g @catppuccin_status_modules_right "user host session"
            set -g @catppuccin_status_left_separator  " "
            # set -g @catppuccin_status_left_separator "█"
            set -g @catppuccin_status_right_separator ""
            # set -g @catppuccin_status_right_separator "█"
            set -g @catppuccin_status_right_separator_inverse "no"
            set -g @catppuccin_status_fill "all"
            set -g @catppuccin_status_connect_separator "no"
            set -g @catppuccin_directory_text "#{pane_current_path}"
          '';
        }
      ];

    extraConfig = with config.theme; with pkgs.tmuxPlugins;
    ''
      #################################################
      #
      #  BASIC Setting
      #
      
      # ペインの番号を 1 から開始
      setw -g pane-base-index 1
      # ウィンドウを閉じた時に番号を詰める
      set-option -g renumber-windows on
      
      set -s escape-time 0
      
      #################################################
      #
      #  KEY BINDING Setting
      #
      
      # use vim keybind
      set-window-option -g mode-keys vi
      
      #  vimのコピーを適用
      bind -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi 'C-v' send -X rectangle-toggle
      bind -T copy-mode-vi 'V' send-keys -X select-line
      bind -T copy-mode-vi 'Escape' send-keys -X clear-selection
      
      #  Ctrl-o でペインをローテーションしながら移動
      # bind -n C-o select-pane -t :.+
      
      # 設定ファイルをリロード
      bind-key -T prefix r source-file ~/.config/tmux/tmux.conf \; display-message 'Reloard was successful.'
      
      #################################################
      #
      #  Theme Setting
      #

      # transparent statusbar
      set-option -g status-style bg=default

      set -g status-left "#[fg=#8aadf4]󰰡#[fg=#f7768e] #S#[bg=#1a1b2c]"
      set -g window-status-format "#[bg=#1a1b2c]#[fg=#8087a2]#I #W  #[fg=#8087a2]"
      set -g window-status-current-format "#[fg=#e0af68]#I #W  #[fg=#e0af68]"
      set -g status-justify centre
      set -g status-right '#[fg=#ff9e64] #[fg=#ff9e64] %Y-%m-%d '


      #################################################
      #
      #  Other Setting
      #
      
      # yazi image preview
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM
      
      #################################################
      #
      #  PLUGIN Setting
      #
      
      # Key bindings
      # prefix + I: Installs new plugins from GitHub or any other git repository
      # prefix + U: updates plugin(s)
      # prefix + option + u: remove/uninstall plugins not on the plugin list
      
      # # List of plugins
      # run shell '${sensible}/share/tmux-plugins/sensible/sensible.tmux'
      # # ペイン操作のキーバインド追加
      # run shell '${pain-control}/share/tmux-plugins/pain-control/pain-control.tmux'
      # # 表示内容を正規表現で検索
      # run shell '${copycat}/share/tmux-plugins/copycat/copycat.tmux'
      # # システムのクリップボードにコピー
      # run shell '${yank}/share/tmux-plugins/yank/yank.tmux'
      # # ハイライトしているファイルやURLを開く
      # run shell '${open}/share/tmux-plugins/open/open.tmux'
      # # # catppuccin theme
      # # run shell '${catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux'
      # # run shell '${battery}/share/tmux-plugins/battery/battery.tmux'
    '';
  };
}

