{ ... }:
{
  # https://github.com/tomrijndorp/vscode-finditfaster/issues/44
  services.envfs.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
}
