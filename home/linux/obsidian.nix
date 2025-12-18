{ pkgs-unstable, ... }:
let
  obsidian = pkgs-unstable.obsidian;
in {
  home.packages = [ obsidian ];

  xdg.enable = true;
  xdg.desktopEntries.obsidian = {
    name = "Obsidian";
    genericName = "Markdown Knowledge Base";
    comment = "Edit and organize notes";
    exec = "${obsidian}/bin/obsidian %U";
    terminal = false;
    categories = [ "Office" "Utility" ];
    icon = "obsidian";
  };
}
