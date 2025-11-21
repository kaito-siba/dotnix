{ mylib, ... }:
{
  imports = [
    ./core.nix
    ./gh.nix
    ./git.nix
    ./kitty.nix
    ./lazygit.nix
    ./wezterm.nix
    ./wofi.nix
    ./yazi.nix
    ./zsh
    ./helix.nix
    ./neovim
    ./c.nix
    ./tmux
    ./nodejs.nix
    ./starship
    ./ai
    ./javascript.nix
    ./node2nix
    ./rust.nix
  ];
}
