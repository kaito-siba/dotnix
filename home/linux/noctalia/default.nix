{ pkgs, noctalia, ... }:
{
  imports = [ noctalia.homeModules.default ];

  home.packages = with pkgs; [
    gpu-screen-recorder
    wtype
    gradia
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
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
      config = { };
      templates = {
        niri-transparent = {
          input_path = "~/.config/noctalia/templates/niri-transparent.kdl";
          output_path = "~/.config/niri/noctalia-transparent.kdl";
        };
        tmux-theme = {
          input_path = "~/.config/noctalia/templates/tmux.conf";
          output_path = "~/.config/tmux/noctalia.conf";
          post_hook = ''
            TMUX=
            runtime_dir="$XDG_RUNTIME_DIR"
            if [ -z "$runtime_dir" ]; then
              runtime_dir="/run/user/$(id -u)"
            fi
            /etc/profiles/per-user/$(id -un)/bin/tmux -S "$runtime_dir/tmux-$(id -u)/default" source-file ~/.config/tmux/noctalia.conf 2>/dev/null || true
          '';
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
        delta = {
          input_path = "~/.config/noctalia/templates/delta.gitconfig";
          output_path = "~/.config/delta/delta.gitconfig";
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

  # for dynamic gnome color scheme switching with theme hook
  home.file.".local/bin/set-gnome-color-scheme".text = ''
    #!${pkgs.bash}/bin/bash
    if [ "$1" = "true" ]; then
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    fi
  '';
  home.file.".local/bin/set-gnome-color-scheme".executable = true;

  xdg.configFile."noctalia/settings.json".source = ./settings.json;
  xdg.configFile."noctalia/templates".source = ./templates;
}
