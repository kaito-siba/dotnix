{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };

  home.file = {
    ".config/nvim" = {
      source = ./config;
      recursive = true;
    };
  };
}
