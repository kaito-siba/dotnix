{ mylib, ... }:
{
  imports = [
    ./core.nix
    ./gh.nix
    ./git.nix
    ./kitty.nix
    ./lazygit.nix
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
    ./vscode.nix
    ./wezterm.nix
    ./wofi.nix
    ./yazi.nix
    ./zsh.nix
  ];
}
