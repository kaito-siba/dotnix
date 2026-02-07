{ pkgs, noctalia, ... }: {
  imports = [ noctalia.homeModules.default ];

  home.packages = with pkgs; [ gpu-screen-recorder wtype gradia ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [{
        enabled = true;
        name = "Official Noctalia Plugins";
        url = "https://github.com/noctalia-dev/noctalia-plugins";
      }];
      states = {
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        pomodoro = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        currency-exchange = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        translator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 1;
    };

    pluginSettings = {
      pomodoro = {
        workDuration = 25;
        shortBreakDuration = 5;
        longBreakDuration = 15;
        sessionsBeforeLongBreak = 4;
        autoStartBreaks = true;
        autoStartWork = true;
        compactMode = true;
      };
    };

    user-templates = {
      config = {};
      templates = {
        niri-transparent = {
          input_path = "~/.config/noctalia/templates/niri-transparent.kdl";
          output_path = "~/.config/niri/noctalia-transparent.kdl";
        };
        tmux-theme = {
          input_path = "~/.config/noctalia/templates/tmux.conf";
          output_path = "~/.config/tmux/noctalia.conf";
          post_hook = "tmux source-file ~/.config/tmux/noctalia.conf 2>/dev/null || true";
        };
        lualine-theme = {
          input_path = "~/.config/noctalia/templates/lualine-theme.lua";
          output_path = "~/.config/nvim/lua/data/lualine-theme.lua";
          post_hook = "pkill -SIGUSR1 nvim";
        };
        lualine-colors = {
          input_path = "~/.config/noctalia/templates/lualine-colors.lua";
          output_path = "~/.config/nvim/lua/data/lualine-colors.lua";
          post_hook = "pkill -SIGUSR1 nvim";
        };
        starship = {
          input_path = "~/.config/noctalia/templates/starship.toml";
          output_path = "~/.config/starship.toml";
        };
        nvim-base16 = {
          input_path = "~/.config/nvim/lua/data/matugen-template.lua";
          output_path = "~/.config/nvim/lua/data/matugen.lua";
          post_hook = "pkill -SIGUSR1 nvim";
        };
      };
    };
    # this may also be a string or a path to a JSON file.
  };

  xdg.configFile."noctalia/settings.json".source = ./settings.json;
  xdg.configFile."noctalia/templates".source = ./templates;
}
