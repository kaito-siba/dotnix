{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lmstudio
  ];

  services.ollama = {
    enable = true;
  };
}
