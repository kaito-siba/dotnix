{ pkgs, ...}:
let
  myFonts = pkgs.stdenv.mkDerivation {
    pname = "my-local-fonts";
    version = "2025-08-07";
    src = ./fonts;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src/*.ttf $out/share/fonts/truetype/
    '';
  };
in {
  fonts = {
    fontDir.enable = true;
    packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-emoji
      pkgs.dejavu_fonts
      pkgs.nerd-fonts.jetbrains-mono
      myFonts
    ];

    enableDefaultPackages = false;

    fontconfig.defaultFonts = {
      serif = [
        "Noto Sefif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans CJK JP"
        "Noto Sans"
        "Noto Color Emoji"
        "Guguru Sans Code 35"
      ];
      monospace = [
        "Noto Sans Mono"
        "Noto Color Emoji"
        "Dejavu Sans Mono"
      ];
      emoji = [ "Noto Color Emoji" ];
    };

    # https://wiki.nixos.org/wiki/Fonts
    # Noto Color Emoji doesn't render on Firefox
    fontconfig.useEmbeddedBitmaps = true;
  };
}
