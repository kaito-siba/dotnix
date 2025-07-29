{config, pkgs, ... }:let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "de53d90cb2740f84ae595f93d0c4c23f8618a9e4";
    hash = "sha256-ixZKOtLOwLHLeSoEkk07TB3N57DXoVEyImR3qzGUzxQ=";
  };
in {
  home = {
    username = "w963n";
    homeDirectory = "/home/w963n";
    stateVersion = "25.05";
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Electron apps to use Wayland
    };
  };

  home.packages = with pkgs; [
    neofetch

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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
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

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        show_hidden = true;
      };
      preview = {
        max_width = 1000;
	max_height = 1000;
      };
    };

    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
    };

    keymap = {
      mgr.prepend_keymap = [
        {
	  on = ["c" "m"];
	  run = "plugin chmod";
	  desc = "Chmod on selected files";
	}
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      ls = "exa --icons";
      lg = "lazygit";
      # y = "yazi";
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
}
