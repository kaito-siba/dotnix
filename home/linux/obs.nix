{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      # wlrobs  # wlroots screen capture (PipeWireキャプチャがあれば不要)
    ];
  };
}
