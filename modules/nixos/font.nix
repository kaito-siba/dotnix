{ pkgs, ...}:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      dejavu_fonts
      nerd-fonts.jetbrains-mono
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
      ];
      monospace = [
        "Noto Sans Mono"
	"Noto Color Emoji"
	"Dejavu Sans Mono"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
