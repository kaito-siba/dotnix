{config, pkgs, ... }:

{
  home.username = "w963n";
  home.homeDirectory = "/home/w963n";

  home.packages = with pkgs; [
    neofetch
    yazi # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    jq
    yq-go
    eza
    fzf

    # productivity
    lazygit
    gh

    # gui
    slack
    notion-app-enhanced
  ];

  programs.git = {
    enable = true;
    userName = "k-nanchi";
    userEmail = "kaito@siba-service.jp";
  }; 

  programs.starship = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
  };
  
  programs.firefox = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      ls = "exa --icons";
      lg = "lazygit";
      y = "yazi";
    };
  };

  programs.wezterm = {
    enable = true;
    # package = inputs.wezterm.packages.${pkgs.system}.default;
  };

  programs.wofi = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "ALT";
      bind = 
        [
          "$mod, B, exec, firefox"
          "$mod, T, exec, kitty"
	  "SUPER, SPACE, exec, wofi --show drun"
        ]
        ++ (
         # workspaces
         # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
         builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );
    };
    extraConfig = ''
    monitor=DP-6,3840x2160@60,0x0,1.5
    monitor=HDMI-A-3,1920x1080@60,2560x360,1
    '';
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps to use Wayland
  };
  
  home.stateVersion = "25.05";
}
