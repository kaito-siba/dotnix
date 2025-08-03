{
  programs.vscode = {
    enable = true;

    extensions = import ./extensions.nix;
    userSettings = import ./settings.nix;
    keybindings = import ./keybindings.nix;
  };
}
