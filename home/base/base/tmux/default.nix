{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    shell = "${pkgs.zsh}/bin/zsh";
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
      ];
    extraConfig = with config.theme; with pkgs.tmuxPlugins;
    ''
      #################################################
      #
      #  BASIC Setting
      #
      
      #
      #  Prefix キーを Ctrl-b から Ctrl-q に変更
      #
      set -g prefix C-q
      unbind C-b
      
      # ウィンドウの番号を 1 から開始
      set -g base-index 1
      # ペインの番号を 1 から開始
      setw -g pane-base-index 1
      # ウィンドウを閉じた時に番号を詰める
      set-option -g renumber-windows on
      
      set -s escape-time 0
      set-option -g mouse on
      
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
      
      # set -g @catppuccin_flavor "latte"
      # set -g @catppuccin_window_status_style "basic"
      # set -g @catppuccin_status_background "none"
      # 
      # # window-status のフォーマットを指定する
      # set -ogq @catppuccin_window_text " #W"
      # set -ogq @catppuccin_window_number "#I"
      # set -ogq @catppuccin_window_current_text " #W"
      # set -ogq @catppuccin_window_current_number "#I"
      # 
      # set -g status-right-length 100
      # set -g status-left-length 100
      # set -g status-left ""
      # set -g status-right "#{E:@catppuccin_status_application}"
      # set -ag status-right "#{E:@catppuccin_status_session}"
      # set -ag status-right "#{E:@catppuccin_status_uptime}"
      # set -agF status-right "#{E:@catppuccin_status_battery}"
      
      
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

